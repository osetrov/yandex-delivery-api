module YandexDelivery

  def request method_name, params={}
    params = build_params method_name, params
    result = RestClient.post "https://delivery.yandex.ru/api/last/#{method_name.to_s.camelize(:lower)}", params
    JSON.parse(result)
  end

  def build_params method_name, params={}
    params[:client_id] = YandexDelivery.client["id"]
    params[:sender_id] = params[:sender_id] || YandexDelivery.senders.first["id"]
    params[:secret_key] = Digest::MD5.hexdigest("#{post_values(params)}#{YandexDelivery.send("#{method_name}_key")}")
    params
  end

  class << self

    def setup
      yield self
    end

    def request method_name, params={}
      params = build_params method_name, params
      result = RestClient.post "https://delivery.yandex.ru/api/last/#{method_name.to_s.camelize(:lower)}", params
      JSON.parse(result)
    end

    def build_params method_name, params={}
      params[:client_id] = YandexDelivery.client["id"]
      params[:sender_id] = params[:sender_id] || YandexDelivery.senders.first["id"]
      params[:secret_key] = Digest::MD5.hexdigest("#{post_values(params)}#{YandexDelivery.send("#{method_name}_key")}")
      params
    end

    def post_values params
      return params unless params.kind_of?(Array) || params.kind_of?(Hash)
      params.sort.map{|k,v|
        if params.kind_of?(Array)
          post_values(k)
        else
          post_values(v)
        end
      }.join('')
    end

    def create_method name
      define_singleton_method(name) do |params = {}|
        request name, params
      end
      define_method(name) do |params = {}|
        request name, params
      end
    end

    def register(name, value, type = nil)
      cattr_accessor "#{name}_setting".to_sym

      add_reader(name)
      add_writer(name, type)
      send "#{name}=", value
    end

    def add_reader(name)
      define_singleton_method(name) do |*args|
        send("#{name}_setting").value(*args)
      end
    end

    def add_writer(name, type)
      define_singleton_method("#{name}=") do |value|
        send("#{name}_setting=", DynamicSetting.build(value, type))
      end
    end
  end

  class DynamicSetting
    def self.build(setting, type)
      (type ? klass(type) : self).new(setting)
    end

    def self.klass(type)
      klass = "#{type.to_s.camelcase}Setting"
      raise ArgumentError, "Unknown type: #{type}" unless YandexDelivery.const_defined?(klass)
      YandexDelivery.const_get(klass)
    end

    def initialize(setting)
      @setting = setting
    end

    def value(*_args)
      @setting
    end
  end

end
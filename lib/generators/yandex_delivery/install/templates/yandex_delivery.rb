require 'yandex_delivery'

YandexDelivery.setup do |config|
  if File.exist?('config/yandex_delivery.yml')
    template = ERB.new(File.new('config/yandex_delivery.yml').read)
    processed = YAML.safe_load(template.result(binding))

    processed['YANDEX_DELIVERY_API_KEY'].each do |k, v|
      config::create_method k.underscore.to_sym
      config::register "#{k.underscore}_key".to_sym, v
    end

    processed['YANDEX_DELIVERY'].each do |k, v|
      config::register k.underscore.to_sym, v
    end
  end
end
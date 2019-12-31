# frozen_string_literal: true

module YandexDelivery
  module Generators
    class YandexDeliveryGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def generate_install
        copy_file 'yandex.yml', 'app/config/ability.rb'
        copy_file 'yandex_delivery.rb', 'app/config/initializers/yandex_delivery.rb'
      end
    end
  end
end

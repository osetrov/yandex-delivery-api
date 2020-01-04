## Installation

Добавьте в Gemfile:

    gem 'yandex-delivery-api', github: 'osetrov/yandex-delivery-api'

и запустите `bundle install`.

Затем:

    rails g yandex_delivery:install

в файл `config/yandex_delivery.yml` вставьте ваши данные из настоек яндекс доставки:

https://delivery.yandex.ru/integration/index

Все возможные запросы:
https://tech.yandex.ru/delivery/doc/dg/about-docpage/

Например "Получить варианты доставки":
```erb
params = {
    :city_from => 'Санкт-Петербург',
    :city_to => 'Москва',
    :delivery_type => 'todoor',
    :weight => 2,
    :length => 18,
    :width => 3,
    :height => 3,
    :order_cost => 1000
}

YandexDelivery::search_delivery_list params
```

secret_key, client_id, sender_id указывать в параметрах не обязательно.

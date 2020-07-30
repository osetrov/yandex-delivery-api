Gem::Specification.new do |s|
  s.name        = 'yandex-delivery-api'
  s.version     = '0.0.5'
  s.date        = '2020-07-30'
  s.summary     = "Yandex delivery api"
  s.description = ""
  s.authors     = ["Pavel Osetrov"]
  s.email       = 'pavel.osetrov@me.com'
  s.files = Dir['lib/**/*', 'LICENSE', 'README.md']

  s.homepage    = 'https://github.com/osetrov/yandex-delivery-api'
  s.license       = 'MIT'

  s.add_development_dependency('rest-client', '~> 2.0.0')

  s.required_ruby_version = '>= 2.0.0'
end

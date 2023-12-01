module Consul
  class Application < Rails::Application
    config.i18n.default_locale = "so"
    available_locales = [
      "en",
      "so",]
    config.i18n.available_locales = available_locales
    config.i18n.fallbacks = [I18n.default_locale, {
      "so"    => "en",
    }]
  end
end

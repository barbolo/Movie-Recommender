# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Extra models
  config.load_paths += %W( #{RAILS_ROOT}/../mr/models)
  
  # Timezone
  config.time_zone = 'Brasilia'

  # Locale
  config.i18n.default_locale = "pt-br"
end

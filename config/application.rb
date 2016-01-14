require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)
module BedSafe
  # Application
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.assets.enabled = true
    config.assets.precompile += %w(welcome.css users.css product.css address.js admin.css)
    config.active_record.raise_in_transactional_callbacks = true
  end
end

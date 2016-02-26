require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)
module BedSafe
  # Application
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.assets.enabled = true
    config.assets.precompile += %w(welcome.css users.css product.css address.js admin.css upload.js base.js 
    jquery.ui.datepicker-zh-CN.js select2.full.min.js select2.min.css)
    config.active_record.raise_in_transactional_callbacks = true
    config.i18n.default_locale = 'zh-CN'

    # mysql mongo环境切换
    config.generators do |g|
  		g.orm :active_record
		end
  end
end

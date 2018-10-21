# frozen_string_literal: true

module ForemanConcrete
  class Engine < ::Rails::Engine
    engine_name 'foreman_concrete'

    config.autoload_paths += Dir["#{config.root}/app/lib"]
    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]

    initializer 'foreman_concrete.load_default_settings', before: :load_config_initializers do
      require_dependency File.expand_path('../../app/models/setting/concrete.rb', __dir__) if begin
                                                                                                Setting.table_exists?
                                                                                              rescue StandardError
                                                                                                false
                                                                                              end
    end

    initializer 'foreman_concrete.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_concrete do
        requires_foreman '>= 1.19'
      end
    end

    initializer 'foreman_concrete.configure_sentry', after: :load_environment_config do
      require 'foreman_concrete/configure_sentry'
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Foreman::Exception.send(:include, ForemanConcrete::Extensions::Foreman::Exception)
        Foreman::LoggingImpl.send(:include, ForemanConcrete::Extensions::Foreman::Logging)
        ApplicationController.send(:include, ForemanConcrete::ApplicationControllerExtensions)
        Api::BaseController.send(:include, ForemanConcrete::Api::BaseControllerExtensions)
      rescue StandardError => e
        Raven.capture_exception(e)
        Rails.logger.warn "ForemanConcrete: skipping engine hook (#{e})"
      end
    end
  end
end

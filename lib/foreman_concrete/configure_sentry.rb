# frozen_string_literal: true

require 'raven'
require 'raven/breadcrumbs/logger'

::Raven.configure do |config|
  config.logger = Foreman::Logging.logger('foreman_concrete')
  config.dsn = Setting[:sentry_dsn]
  config.release = SETTINGS[:version].version
  config.rails_activesupport_breadcrumbs = true
end

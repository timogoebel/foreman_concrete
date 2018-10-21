# frozen_string_literal: true

class Setting
  class Concrete < ::Setting
    Setting::BLANK_ATTRS.push('sentry_dsn')

    def self.default_settings
      [
        set('sentry_dsn', N_('The DSN of your Sentry server'), '', N_('Sentry DSN'))
      ]
    end

    def self.load_defaults
      return unless super

      transaction do
        default_settings.compact.each { |s| create! s.update(category: 'Setting::Concrete') }
      end

      true
    end

    def self.humanized_category
      N_('Sentry')
    end
  end
end

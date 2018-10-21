# frozen_string_literal: true

module ForemanConcrete
  module Extensions
    module Foreman
      module Logging
        extend ActiveSupport::Concern

        module Overrides
          def exception(context_message, exception, options = {})
            super
            raven_context = {
              extra: {
                context_message: context_message
              },
              level: options[:level] || :warn,
              logger: options[:logger] || 'app'
            }
            Raven.capture_exception(exception, raven_context)
          end
        end

        included do
          prepend Overrides
        end
      end
    end
  end
end

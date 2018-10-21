# frozen_string_literal: true

module ForemanConcrete
  module Extensions
    module Foreman
      module Exception
        extend ActiveSupport::Concern

        def raven_context
          {
            extra: {
              erf_code: code
            }
          }
        end
      end
    end
  end
end

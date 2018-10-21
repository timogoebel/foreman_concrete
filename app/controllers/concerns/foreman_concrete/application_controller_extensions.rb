# frozen_string_literal: true

module ForemanConcrete
  module ApplicationControllerExtensions
    extend ActiveSupport::Concern

    module Overrides
      def generic_exception(exception)
        Foreman::Logging.exception('Action failed', exception)
        render template: 'foreman_concrete/500', layout: !request.xhr?, status: :internal_server_error, locals: { exception: exception, raven_id: Raven.last_event_id }
      end
    end

    included do
      prepend Overrides
      include ForemanConcrete::SetRavenContext
    end
  end
end

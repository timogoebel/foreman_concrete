# frozen_string_literal: true

module ForemanConcrete
  module SetRavenContext
    extend ActiveSupport::Concern

    included do
      before_action :set_raven_context
    end

    private

    def set_raven_context
      Raven.user_context(
        id: User.current&.id,
        login: User.current&.login,
        email: User.current&.mail
      )
      Raven.extra_context(
        request_id: request.uuid
      )
    end
  end
end

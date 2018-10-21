# frozen_string_literal: true

module ForemanConcrete
  module Api
    module BaseControllerExtensions
      extend ActiveSupport::Concern

      included do
        include ForemanConcrete::SetRavenContext

        # Prepend our view path so we can display
        # the last ravel event id in the error message
        before_action :prepend_concrete_view_path
      end

      def prepend_concrete_view_path
        engine_root = ForemanConcrete::Engine.root.to_s
        prepend_view_path File.join(engine_root, 'app/views')
      end
    end
  end
end

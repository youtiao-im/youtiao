module Api
  module V1
    class ApiController < ActionController::Base
      include Pundit

      before_action :doorkeeper_authorize!
      before_action :set_format_json

      helper_method :current_resource_owner

      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

      def pundit_user
        current_resource_owner
      end

      private

      def set_format_json
        request.format = :json
      end
    end
  end
end

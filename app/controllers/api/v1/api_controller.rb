module Api
  module V1
    class ApiController < ActionController::Base
      include Pundit

      rescue_from ActionController::ParameterMissing,
                  ActiveRecord::RecordInvalid,
                  ActionController::BadRequest,
                  Mutations::ValidationException do |exception|
        render json: exception, status: :bad_request
      end

      rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: exception, status: :not_found
      end

      rescue_from Pundit::NotAuthorizedError do |exception|
        render json: exception, status: :forbidden
      end

      rescue_from ActiveRecord::RecordNotUnique do |exception|
        render json: exception, status: :conflict
      end

      before_action :doorkeeper_authorize!
      before_action :set_format_json

      helper_method :current_resource_owner

      def current_resource_owner
        @current_resource_owner ||=
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

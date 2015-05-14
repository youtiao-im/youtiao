module Api
  module V1
    class AuthenticatedUsersController < ApiController
      def show
        render json: current_resource_owner
      end
    end
  end
end

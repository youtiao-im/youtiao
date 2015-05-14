module Api
  module V1
    class AuthenticatedUsersController < ApiController
      decorates_assigned :user

      def show
        @user = current_resource_owner
      end
    end
  end
end

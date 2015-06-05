module Api
  module V1
    class AuthenticatedUsersController < ApiController
      decorates_assigned :user
      decorates_assigned :feeds

      def show
        @user = current_resource_owner
      end

      def feeds
        @feeds = paginate current_resource_owner.feeds.includes(
          :channel, :mark, :created_by)
      end
    end
  end
end

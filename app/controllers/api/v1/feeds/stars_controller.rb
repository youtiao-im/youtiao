module Api
  module V1
    module Feeds
      class StarsController < ApiController
        before_action :set_feed

        decorates_assigned :stars
        decorates_assigned :star

        def index
          authorize @feed.channel, :admin?
          @stars = paginate @feed.stars.includes(:user)
        end

        def show
          authorize @feed.channel, :admin?
          @star = Star.pinpoint(@feed.id, decrypted_user_id)
        end

        private

        def set_feed
          @feed = Feed.find(Feed.decrypt_id(params[:feed_id]))
        end

        def decrypted_user_id
          User.decrypt_id(params[:user_id])
        end
      end
    end
  end
end

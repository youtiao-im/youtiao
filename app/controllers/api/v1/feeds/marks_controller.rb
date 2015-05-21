module Api
  module V1
    module Feeds
      class MarksController < ApiController
        before_action :set_feed

        decorates_assigned :marks
        decorates_assigned :mark

        def index
          authorize @feed.channel, :admin?
          @marks = paginate @feed.marks.includes(:user)
        end

        def show
          authorize @feed.channel, :admin?
          @mark = Mark.pinpoint(@feed.id, decrypted_user_id)
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

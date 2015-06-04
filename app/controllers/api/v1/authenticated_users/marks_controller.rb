module Api
  module V1
    module AuthenticatedUsers
      class MarksController < ApiController
        before_action :set_feed, except: [:index]

        decorates_assigned :marks
        decorates_assigned :mark

        def index
          @marks = paginate current_resource_owner.marks.includes(
            :feed, feed: [:channel, :created_by])
        end

        def show
          @mark = Mark.pinpoint(@feed.id, current_resource_owner.id)
        end

        def set
          authorize @feed.channel, :show?
          @mark = Marks::Set.run!(
            safe_create_params.merge(
              feed_id: @feed.id, user_id: current_resource_owner.id))
          @mark.feed.reload
          render :show
        end

        private

        def set_feed
          @feed = Feed.find(Feed.decrypt_id(params[:feed_id]))
        end

        def safe_create_params
          params.permit(:symbol)
        end
      end
    end
  end
end

module Api
  module V1
    module AuthenticatedUsers
      class MarkedFeedsController < ApiController
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

        def create_or_update
          authorize @feed.channel, :show?
          @mark = Mark.new(safe_create_or_update_params)
          @mark.feed = @feed
          @mark.user = current_resource_owner
          @mark = MarkedFeeds::CreateOrUpdate.run!(@mark.attributes)
          @mark.feed.reload
          render :show
        end

        private

        def set_feed
          @feed = Feed.find(Feed.decrypt_id(params[:id]))
        end

        def safe_create_or_update_params
          params.permit(:symbol)
        end
      end
    end
  end
end

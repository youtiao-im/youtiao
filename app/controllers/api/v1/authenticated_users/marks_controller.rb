module Api
  module V1
    module AuthenticatedUsers
      class MarksController < ApiController
        before_action :set_feed, except: [:index]

        decorates_assigned :marks
        decorates_assigned :mark

        def index
          @marks = paginate current_resource_owner.marks.includes(
            :feed, feed: [:created_by, :mark, :star])
        end

        def show
          @mark = Mark.pinpoint(@feed.id, current_resource_owner.id)
        end

        def create
          authorize @feed.channel, :show?
          @mark = Mark.new(safe_create_params)
          @mark.feed = @feed
          @mark.user = current_resource_owner
          @mark = Marks::Create.run!(@mark.attributes)
          render :show
        end

        def update
          authorize @feed.channel, :show?
          @mark = Mark.pinpoint(@feed.id, current_resource_owner.id)
          @mark = Marks::Update.run!(safe_update_params.merge(mark: @mark))
          render :show
        end

        private

        def set_feed
          @feed = Feed.find(Feed.decrypt_id(params[:feed_id]))
        end

        def safe_create_params
          params.permit(:symbol)
        end

        def safe_update_params
          params.permit(:symbol)
        end
      end
    end
  end
end

module Api
  module V1
    module AuthenticatedUsers
      class MarksController < ApiController
        decorates_assigned :marks
        decorates_assigned :mark

        def index
          @marks = current_resource_owner.marks
        end

        def show
          @mark = Mark.pinpoint(params[:feed_id], current_resource_owner.id)
        end

        def create
          @feed = Feed.find(params[:feed_id])
          authorize @feed.channel, :show?
          @mark = Mark.new(safe_create_params)
          @mark.feed = @feed
          @mark.user = current_resource_owner
          @mark.save!
          render :show
        end

        def update
          @feed = Feed.find(params[:feed_id])
          authorize @feed.channel, :show?
          @mark = Mark.pinpoint(@feed.id, current_resource_owner.id)
          @mark.update(safe_update_params)
          render :show
        end

        private

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

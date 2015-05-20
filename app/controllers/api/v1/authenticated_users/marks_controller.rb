module Api
  module V1
    module AuthenticatedUsers
      class MarksController < ApiController
        before_action :set_feed, except: [:index]

        decorates_assigned :marks, context: (lambda do |controller|
          { current_user: controller.current_resource_owner }
        end)
        decorates_assigned :mark, context: (lambda do |controller|
          { current_user: controller.current_resource_owner }
        end)

        def index
          @marks = paginate current_resource_owner.marks
        end

        def show
          @mark = Mark.pinpoint(@feed.id, current_resource_owner.id)
        end

        def create
          authorize @feed.channel, :show?
          @mark = Mark.new(safe_create_params)
          @mark.feed = @feed
          @mark.user = current_resource_owner
          @mark.save!
          render :show
        end

        def update
          authorize @feed.channel, :show?
          @mark = Mark.pinpoint(@feed.id, current_resource_owner.id)
          @mark.update_attributes(safe_update_params)
          @mark.save!
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

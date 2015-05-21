module Api
  module V1
    module AuthenticatedUsers
      class StarsController < ApiController
        before_action :set_feed, except: [:index]

        decorates_assigned :stars, context: (lambda do |controller|
          { current_user: controller.current_resource_owner }
        end)
        decorates_assigned :star, context: (lambda do |controller|
          { current_user: controller.current_resource_owner }
        end)

        def index
          @stars = paginate current_resource_owner.stars
        end

        def show
          @star = Star.pinpoint(@feed.id, current_resource_owner.id)
        end

        def create
          authorize @feed.channel, :show?
          @star = Star.new
          @star.feed = @feed
          @star.user = current_resource_owner
          @star = Stars::Create.run!(@star.attributes)
          render :show
        end

        private

        def set_feed
          @feed = Feed.find(Feed.decrypt_id(params[:feed_id]))
        end
      end
    end
  end
end

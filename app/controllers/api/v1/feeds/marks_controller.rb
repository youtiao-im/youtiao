module Api
  module V1
    module Feeds
      class MarksController < ApiController
        decorates_assigned :marks
        decorates_assigned :mark

        def index
          @feed = Feed.find(params[:feed_id])
          authorize @feed.channel, :admin?
          @marks = @feed.marks
        end

        def show
          @feed = Feed.find(params[:feed_id])
          authorize @feed.channel, :admin?
          @mark = Mark.pinpoint(@feed.id, params[:user_id])
        end
      end
    end
  end
end

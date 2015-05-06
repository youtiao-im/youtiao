module Api
  module V1
    class FeedsController < ApiController
      before_action :set_channel, only: [:index, :create]
      before_action :set_feed, except: [:index, :create]

      decorates_assigned :feeds
      decorates_assigned :feed

      def index
        authorize Feed.new
        @feeds = policy_scope(Feed)
      end

      def show
        authorize @feed
      end

      def create
        @feed = Feed.new(safe_create_params)
        @feed.channel = @channel
        @feed.creator = current_resource_owner
        authorize @feed
        @feed.save!
        render :show
      end

      def feedback
        authorize @feed

        # TODO: simplify me
        if params[:sticker].nil?
          render status: :bad_request, nothing: true
          return
        end

        begin
          Feedback.create(feed: @feed, creator: current_resource_owner, sticker: params[:sticker])
        rescue ActiveRecord::RecordNotUnique
          feedback = Feedback.find_by(feed: @feed, creator: current_resource_owner)
          feedback.sticker = params[:sticker]
          feedback.save
        end

        render nothing: true
      end

      private

      def set_channel
        @channel = Channel.find(params[:channel_id])
        current_resource_owner.current_channel = @channel
      end

      def set_feed
        @feed = Feed.find(params[:id])
        current_resource_owner.current_channel = @feed.channel
      end

      def safe_create_params
        params.permit(:content)
      end
    end
  end
end

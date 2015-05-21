require 'text_formatter'

module Api
  module V1
    class FeedsController < ApiController
      before_action :set_channel, only: [:index, :create]
      before_action :set_feed, except: [:index, :create]

      decorates_assigned :feeds, context: (lambda do |controller|
        { current_user: controller.current_resource_owner }
      end)
      decorates_assigned :feed, context: (lambda do |controller|
        { current_user: controller.current_resource_owner }
      end)

      def index
        authorize @channel, :show?
        @feeds = paginate @channel.feeds
      end

      def show
        authorize @feed.channel, :show?
      end

      def create
        authorize @channel, :admin?
        @feed = Feed.new(safe_create_params)
        @feed.channel = @channel
        @feed.created_by = current_resource_owner
        @feed = Feeds::Create.run!(@feed.attributes)
        render :show
      end

      private

      def set_channel
        @channel = Channel.find(params[:channel_id])
      end

      def set_feed
        @feed = Feed.find(params[:id])
      end

      def safe_create_params
        params.permit(:text)
      end
    end
  end
end

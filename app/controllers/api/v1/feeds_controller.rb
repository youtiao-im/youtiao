module Api
  module V1
    class FeedsController < ApiController
      before_action :set_channel, only: [:index, :create]
      before_action :set_feed, except: [:index, :create]

      decorates_assigned :feeds, context: ->(controller) do
        { current_user: controller.current_resource_owner }
      end
      decorates_assigned :feed, context: ->(controller) do
        { current_user: controller.current_resource_owner }
      end

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

      def stamp
        authorize @feed

        # TODO: simplify me
        if params[:kind].nil?
          render status: :bad_request, nothing: true
          return
        end

        begin
          Stamp.create(feed: @feed, user: current_resource_owner, kind: params[:kind])
        rescue ActiveRecord::RecordNotUnique
          stamp = Stamp.find_by(feed: @feed, user: current_resource_owner)
          stamp.kind = params[:kind]
          stamp.save
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

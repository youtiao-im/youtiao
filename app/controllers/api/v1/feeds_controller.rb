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
        authorize Feed.new
        @feeds = paginate(policy_scope(Feed))
      end

      def show
        authorize @feed
      end

      def create
        # TODO: move to service
        @feed = Feed.new(safe_create_params)
        @feed.channel = @channel
        @feed.creator = current_resource_owner
        authorize @feed
        @feed.save!
        unless params[:attachments].nil?
          params[:attachments].each do |attachment|
            @feed.attachments << Attachment.new(text: attachment[:text], url: attachment[:url])
          end
        end
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
        params.permit(:text)
      end
    end
  end
end

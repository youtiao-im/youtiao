module Api
  module V1
    class ChannelsController < ApiController
      before_action :set_channel, except: [:index, :create]

      decorates_assigned :channels
      decorates_assigned :channel

      def index
        authorize Channel.new
        @channels = policy_scope(Channel)
      end

      def show
        authorize @channel
      end

      def create
        @channel = Channel.new(safe_create_params)
        @channel.creator = current_resource_owner
        authorize @channel
        # TODO: move to service
        @channel.save!
        ChannelUser.create!(channel: @channel, user: current_resource_owner, role: :owner)
        render :show
      end

      def join
        # TODO: this is ugly
        begin
          ChannelUser.create(channel: @channel, user: current_resource_owner, role: :member)
        rescue ActiveRecord::RecordNotUnique
          # ignore
        end
        render nothing: true
      end

      private

      def set_channel
        @channel = Channel.find(params[:id])
      end

      def safe_create_params
        params.permit(:name)
      end
    end
  end
end

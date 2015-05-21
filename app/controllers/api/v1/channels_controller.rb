module Api
  module V1
    class ChannelsController < ApiController
      before_action :set_channel, except: [:index, :create]

      decorates_assigned :channels
      decorates_assigned :channel

      def show
        authorize @channel
      end

      def create
        @channel = Channel.new(safe_create_params)
        @channel.created_by = current_resource_owner
        authorize @channel
        @channel = Channels::Create.run!(@channel.attributes)
        render :show
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

module Api
  module V1
    class ChannelsController < ApiController
      before_action :set_channel, except: [:index, :create]

      decorates_assigned :channels,
                         context: ->(controller) {
                           { current_user: controller.current_resource_owner }
                         }
      decorates_assigned :channel,
                         context: ->(controller) {
                           { current_user: controller.current_resource_owner }
                         }

      def index
        @channels = policy_scope(Channel)
      end

      def show
        if @channel.nil?
          render status: :not_found
        else
          begin
            authorize @channel
          rescue NotAuthorizedError
            render status: :forbidden
          end
        end
      end

      def create
        begin
          @channel = Channel.create(safe_create_params)
          ChannelUser.create(channel: @channel, user: current_resource_owner, role: :admin)
          render :show
        rescue ActiveRecord::StatementInvalid
          render status: :bad_request
        rescue ActiveRecord::RecordNotUnique
          render status: :conflict
        end
      end

      def update

      end

      def subscribe
        if @channel.nil?
          render status: :not_found
        else
          begin
            ChannelUser.create(channel: @channel, user: current_resource_owner, role: :subscriber)
          rescue ActiveRecord::RecordNotUnique
            render status: :ok
          end
        end
      end


      private
      def set_channel
        begin
          @channel = Channel.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          @channel = nil
        end
      end

      def safe_create_params
        params.permit(:name)
      end
    end
  end
end

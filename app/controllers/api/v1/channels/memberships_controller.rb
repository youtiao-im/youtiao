module Api
  module V1
    module Channels
      class MembershipsController < ApiController
        before_action :set_channel

        decorates_assigned :memberships
        decorates_assigned :membership

        def index
          authorize @channel, :show?
          @memberships = paginate @channel.memberships.includes(:user)
        end

        def show
          authorize @channel, :show?
          @membership = Membership.pinpoint(@channel.id, decrypted_user_id)
        end

        private

        def set_channel
          @channel = Channel.find(Channel.decrypt_id(params[:channel_id]))
        end

        def decrypted_user_id
          User.decrypt_id(params[:user_id])
        end
      end
    end
  end
end

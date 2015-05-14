module Api
  module V1
    module Channels
      class MembershipsController < ApiController
        decorates_assigned :memberships
        decorates_assigned :membership

        def index
          @channel = Channel.find(params[:channel_id])
          authorize @channel, :show?
          @memberships = paginate @channel.memberships
        end

        def show
          @channel = Channel.find(params[:channel_id])
          authorize @channel, :show?
          @membership = Membership.pinpoint(@channel.id, params[:user_id])
        end
      end
    end
  end
end

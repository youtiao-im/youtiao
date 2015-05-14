module Api
  module V1
    module AuthenticatedUsers
      class MembershipsController < ApiController
        decorates_assigned :memberships
        decorates_assigned :membership

        def index
          @memberships = current_resource_owner.memberships
        end

        def show
          @membership = Membership.pinpoint(
            params[:channel_id], current_resource_owner.id)
        end

        def create
          @channel = Channel.find(params[:channel_id])
          @membership = Membership.new
          @membership.channel = @channel
          @membership.user = current_resource_owner
          @membership.role = :member
          @membership.save!
          render :show
        end
      end
    end
  end
end

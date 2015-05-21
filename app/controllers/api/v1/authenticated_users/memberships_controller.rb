module Api
  module V1
    module AuthenticatedUsers
      class MembershipsController < ApiController
        before_action :set_channel, except: [:index]

        decorates_assigned :memberships
        decorates_assigned :membership

        def index
          @memberships = paginate current_resource_owner.memberships.includes(
            :channel, channel: :created_by)
        end

        def show
          @membership = Membership.pinpoint(
            @channel.id, current_resource_owner.id)
        end

        def create
          @membership = Membership.new
          @membership.channel = @channel
          @membership.user = current_resource_owner
          @membership.role = :member
          @membership = Memberships::Create.run!(@membership.attributes)
          render :show
        end

        private

        def set_channel
          @channel = Channel.find(Channel.decrypt_id(params[:channel_id]))
        end
      end
    end
  end
end

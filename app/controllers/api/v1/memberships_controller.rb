class Api::V1::MembershipsController < Api::V1::ApiController
  decorates_assigned :memberships

  def index
    group = Group.find(params[:group_id])
    authorize group, :show?
    @memberships = paginate group.memberships.includes(:user)
  end
end

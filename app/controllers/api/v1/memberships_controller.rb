class Api::V1::MembershipsController < Api::V1::ApiController
  decorates_assigned :memberships

  def index
    group = Group.find(params[:group_id])
    authorize group, :show?
    scope = group.memberships
    unless params[:before_id].nil?
      before_id = Membership.decrypt_id(params[:before_id])
      fail ActionController::BadRequest if before_id.nil?
      scope = scope.before_id(before_id)
    end
    @memberships = limit scope.order(id: :desc).includes(:user)
  end
end

module V1
  class MembershipsAPI < Grape::API
    params do
      requires :group_id, type: String
      optional :before_id, type: String
      optional :limit, type: Integer, default: 25
    end
    get 'memberships.list' do
      group = Group.find(params[:group_id])
      authorize group, :show?
      scope = group.memberships
      scope = scope.before_id(params[:before_id]) unless params[:before_id].nil?
      memberships = scope.order(id: :desc).limit(params[:limit]).includes(
        :user, user: :avatar)
      present memberships, with: Entities::MembershipEntity
    end
  end
end

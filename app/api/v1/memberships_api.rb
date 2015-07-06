module V1
  class MembershipsAPI < Grape::API
    before do
      params[:before_id] = Membership.decrypt_id(params[:before_id]) if params.key?(:before_id)
      params[:group_id] = Group.decrypt_id(params[:group_id]) if params.key?(:group_id)
    end

    params do
      requires :group_id, type: String
      optional :roles, type: Array[Symbol], values: [:owner, :admin, :member]
      optional :before_id, type: String
      optional :limit, type: Integer, default: 25, values: 1..500
    end
    get 'memberships.list' do
      group = Group.find(params[:group_id])
      authorize group, :show?
      scope = group.memberships
      scope = scope.where(role: params[:roles]) unless params[:roles].nil?
      scope = scope.before_id(params[:before_id]) unless params[:before_id].nil?
      memberships = scope.order(id: :desc).limit(params[:limit]).includes(
        :user, user: :avatar)
      present memberships, with: Entities::MembershipEntity
    end
  end
end

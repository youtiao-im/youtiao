module V1
  class MembershipsAPI < Grape::API
    before do
      params[:group_id] = Group.decrypt_id(params[:group_id]) if params.key?(:group_id)
    end

    params do
      requires :group_id, type: String
    end
    get 'memberships.list' do
      group = Group.find(params[:group_id])
      authorize group, :show?
      memberships = group.memberships.includes(:user, user: :avatar)
      present memberships, with: Entities::MembershipEntity
    end
  end
end

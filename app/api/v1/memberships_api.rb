module V1
  class MembershipsAPI < Grape::API
    before do
      params[:id] = Membership.decrypt_id(params[:id]) if params.key?(:id)
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

    params do
      requires :id, type: String
    end
    post 'memberships.promote' do
      membership = Membership.find(params[:id])
      authorize membership.group, :owner?
      if membership.owner?
        fail Pundit::NotAuthorizedError
      else
        membership.update!(role: :admin)
        present membership, with: Entities::MembershipEntity
      end
    end

    params do
      requires :id, type: String
    end
    post 'memberships.demote' do
      membership = Membership.find(params[:id])
      authorize membership.group, :owner?
      if membership.owner?
        fail Pundit::NotAuthorizedError
      else
        membership.update!(role: :member)
        present membership, with: Entities::MembershipEntity
      end
    end
  end
end

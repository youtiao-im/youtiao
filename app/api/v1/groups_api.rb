module V1
  class GroupsAPI < Grape::API
    before do
      params[:id] = Group.decrypt_id(params[:id]) if params.key?(:id)
    end

    get 'groups.list' do
      # TODO: order?
      groups = User.current.groups.includes(:current_membership)
      present groups, with: Entities::GroupEntity
    end

    params do
      requires :id, type: String
    end
    get 'groups.info' do
      group = Group.find(params[:id])
      present group, with: Entities::GroupEntity
    end

    params do
      optional :name, type: String
      optional :code, type: String
    end
    post 'groups.create' do
      safe_params = ActionController::Parameters.new(params).permit(
        :name, :code)
      group = Group.new(safe_params)
      group.created_by = User.current
      group.save!
      membership = Membership.new
      membership.group = group
      membership.user = User.current
      membership.role = :owner
      membership.save!
      group.reload
      present group, with: Entities::GroupEntity
    end

    params do
      requires :id, type: String
      optional :name, type: String
      optional :code, type: String
    end
    post 'groups.update' do
      group = Group.find(params[:id])
      authorize group, :admin?
      safe_params = ActionController::Parameters.new(params).permit(
        :name, :code)
      group.update!(safe_params)
      present group, with: Entities::GroupEntity
    end

    params do
      requires :code, type: String
    end
    post 'groups.join' do
      group = Group.find_by_code!(params[:code])
      membership = Membership.new
      membership.group = group
      membership.user = User.current
      membership.role = :member
      begin
        membership.save!
        group.reload
      rescue ActiveRecord::RecordNotUnique
        # it's ok, ignore it
      end
      present group, with: Entities::GroupEntity
    end
  end
end

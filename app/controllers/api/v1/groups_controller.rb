class Api::V1::GroupsController < Api::V1::ApiController
  decorates_assigned :groups
  decorates_assigned :group

  def index
    @groups = paginate current_resource_owner.groups.includes(
      :current_membership)
  end

  def show
    @group = Group.find(params[:id])
    authorize @group
  end

  def create
    group = Group.new(safe_create_params)
    authorize group
    @group = Groups::Create.run!(group.attributes)
    render :show
  end

  def join
    @group = Group.find(params[:id])
    membership = Membership.new
    membership.group = @group
    membership.user = current_resource_owner
    membership.role = :member
    Memberships::Create.run!(membership.attributes)
    @group.reload
    render :show
  end

  private

  def safe_create_params
    params.permit(:name)
  end
end

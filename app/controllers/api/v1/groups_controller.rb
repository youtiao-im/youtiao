class Api::V1::GroupsController < Api::V1::ApiController
  decorates_assigned :groups
  decorates_assigned :group

  def index
    @groups = current_resource_owner.groups.includes(:current_membership)
  end

  def show
    @group = Group.find(params[:id])
    authorize @group
  end

  def create
    @group = Group.new(safe_create_params)
    @group.created_by = current_resource_owner
    authorize group
    @group.save!
    membership = Membership.new
    membership.group = @group
    membership.user = current_resource_owner
    membership.role = :owner
    membership.save!
    render :show
  end

  def join
    fail ActionController::BadRequest if params[:code].nil?
    @group = Group.find_by_code(params[:code])
    membership = Membership.new
    membership.group = @group
    membership.user = current_resource_owner
    membership.role = :member
    membership.save!
    @group.reload
    render :show
  end

  private

  def safe_create_params
    params.permit(:name)
  end
end

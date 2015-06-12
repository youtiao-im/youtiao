class Api::V1::BulletinsController < Api::V1::ApiController
  decorates_assigned :bulletins
  decorates_assigned :bulletin

  def index
    scope = current_resource_owner.bulletins
    @bulletins = paginate scope.order(id: :desc).includes(
      :group, :created_by, :current_mark, created_by: :user)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin.group, :show?
  end

  def create
    group = Group.find(params[:group_id])
    authorize group, :admin?
    bulletin = Bulletin.new(safe_create_params)
    bulletin.group = group
    bulletin.created_by = group.current_membership
    @bulletin = Bulletins::Create.run!(bulletin.attributes)
    render :show
  end

  def mark
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin.group, :show?
    mark = Mark.new(params.permit(:symbol))
    mark.bulletin = @bulletin
    mark.created_by = @bulletin.group.current_membership
    Marks::CreateOrUpdate.run!(mark.attributes)
    @bulletin.reload
    render :show
  end

  private

  def safe_create_params
    params.permit(:text)
  end
end

class Api::V1::BulletinsController < Api::V1::ApiController
  decorates_assigned :bulletins
  decorates_assigned :bulletin

  def index
    scope = current_resource_owner.bulletins
    @bulletins = paginate scope.order(id: :desc).includes(
      :group, :created_by, :current_stamp, created_by: :user)
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

  def stamp
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin.group, :show?
    stamp = Stamp.new(params.permit(:symbol))
    stamp.bulletin = @bulletin
    stamp.created_by = @bulletin.group.current_membership
    Stamps::CreateOrUpdate.run!(stamp.attributes)
    @bulletin.reload
    render :show
  end

  private

  def safe_create_params
    params.permit(:text)
  end
end

class Api::V1::BulletinsController < Api::V1::ApiController
  decorates_assigned :bulletins
  decorates_assigned :bulletin

  def index
    if !params[:group_id].nil?
      group = Group.find(params[:group_id])
      scope = group.bulletins
    else
      scope = current_resource_owner.bulletins
    end
    unless params[:before_id].nil?
      before_id = Bulletin.decrypt_id(params[:before_id])
      fail ActionController::BadRequest if before_id.nil?
      scope = scope.before_id(before_id)
    end
    @bulletins = limit scope.order(id: :desc).includes(
      :group, :created_by, :current_stamp, created_by: :avatar)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin.group, :show?
  end

  def create
    group = Group.find(params[:group_id])
    authorize group, :admin?
    @bulletin = Bulletin.new(safe_create_params)
    @bulletin.group = group
    @bulletin.created_by = current_resource_owner
    @bulletin.save!
    render :show
  end

  def stamp
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin.group, :show?
    Stamp.destroy_all(bulletin: bulletin, created_by: current_resource_owner)
    stamp = Stamp.new(params.permit(:symbol))
    stamp.bulletin = @bulletin
    stamp.created_by = current_resource_owner
    stamp.save!
    @bulletin.reload
    render :show
  rescue ActiveRecord::RecordInvalid
    fail ActionController::BadRequest
  end

  private

  def safe_create_params
    params.permit(:text)
  end
end

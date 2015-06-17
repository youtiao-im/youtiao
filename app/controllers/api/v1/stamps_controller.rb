class Api::V1::StampsController < Api::V1::ApiController
  decorates_assigned :stamps

  def index
    bulletin = Bulletin.find(params[:bulletin_id])
    authorize bulletin.group, :admin?
    scope = bulletin.stamps
    unless params[:before_id].nil?
      before_id = Stamp.decrypt_id(params[:before_id])
      fail ActionController::BadRequest if before_id.nil?
      scope = scope.before_id(before_id)
    end
    @stamps = limit scope.order(id: :desc).includes(
      :created_by, created_by: :user)
  end
end

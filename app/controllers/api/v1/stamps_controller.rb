class Api::V1::StampsController < Api::V1::ApiController
  decorates_assigned :stamps

  def index
    bulletin = Bulletin.find(params[:bulletin_id])
    authorize bulletin.group, :admin?
    @stamps = paginate bulletin.stamps.includes(:created_by, created_by: :user)
  end
end

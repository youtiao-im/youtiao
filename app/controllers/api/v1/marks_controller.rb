class Api::V1::MarksController < Api::V1::ApiController
  decorates_assigned :marks

  def index
    bulletin = Bulletin.find(params[:bulletin_id])
    authorize bulletin.group, :admin?
    @marks = paginate bulletin.marks.includes(:created_by, created_by: :user)
  end
end

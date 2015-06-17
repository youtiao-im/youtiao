class Api::V1::CommentsController < Api::V1::ApiController
  decorates_assigned :comments
  decorates_assigned :comment

  def index
    bulletin = Bulletin.find(params[:bulletin_id])
    authorize bulletin.group, :show?
    scope = bulletin.comments
    unless params[:after_id].nil?
      after_id = Comment.decrypt_id(params[:after_id])
      fail ActionController::BadRequest if after_id.nil?
      scope = scope.after_id(after_id)
    end
    @comments = limit scope.order(id: :asc).includes(
      :created_by, created_by: :user)
  end

  def show
    @comment = Comment.find(params[:id])
    authorize @comment.bulletin.group, :show?
  end

  def create
    bulletin = Bulletin.find(params[:bulletin_id])
    authorize bulletin.group, :show?
    comment = Comment.new(safe_create_params)
    comment.bulletin = bulletin
    comment.created_by = bulletin.group.current_membership
    @comment = Comments::Create.run!(comment.attributes)
    render :show
  end

  private

  def safe_create_params
    params.permit(:text)
  end
end

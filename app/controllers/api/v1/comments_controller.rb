class Api::V1::CommentsController < Api::V1::ApiController
  decorates_assigned :comments
  decorates_assigned :comment

  def index
    bulletin = Bulletin.find(params[:bulletin_id])
    authorize bulletin.group, :show?
    scope = bulletin.comments
    unless params[:before_id].nil?
      before_id = Comment.decrypt_id(params[:before_id])
      fail ActionController::BadRequest if before_id.nil?
      scope = scope.before_id(before_id)
    end
    @comments = limit scope.order(id: :desc).includes(
      :created_by, created_by: :avatar)
  end

  def show
    @comment = Comment.find(params[:id])
    authorize @comment.bulletin.group, :show?
  end

  def create
    bulletin = Bulletin.find(params[:bulletin_id])
    authorize bulletin.group, :show?
    @comment = Comment.new(safe_create_params)
    @comment.bulletin = bulletin
    @comment.created_by = current_resource_owner
    @comment.save!
    render :show
  end

  private

  def safe_create_params
    params.permit(:text)
  end
end

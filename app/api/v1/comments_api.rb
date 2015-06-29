module V1
  class CommentsAPI < Grape::API
    before do
      params[:id] = Comment.decrypt_id(params[:id]) if params.key?(:id)
      params[:before_id] = Comment.decrypt_id(params[:before_id]) if params.key?(:before_id)
      params[:bulletin_id] = Bulletin.decrypt_id(params[:bulletin_id]) if params.key?(:bulletin_id)
    end

    params do
      requires :bulletin_id, type: String
      optional :before_id, type: String
      optional :limit, type: Integer, default: 25, values: 1..500
    end
    get 'comments.list' do
      bulletin = Bulletin.find(params[:bulletin_id])
      authorize bulletin.group, :show?
      scope = bulletin.comments
      scope = scope.before_id(params[:before_id]) unless params[:before_id].nil?
      comments = scope.order(id: :desc).limit(params[:limit]).includes(
        :created_by, created_by: :avatar)
      present comments, with: Entities::CommentEntity
    end

    params do
      requires :bulletin_id, type: String
      optional :text, type: String
    end
    post 'comments.create' do
      bulletin = Bulletin.find(params[:bulletin_id])
      authorize bulletin.group, :show?
      safe_params = ActionController::Parameters.new(params).permit(:text)
      comment = Comment.new(safe_params)
      comment.bulletin = bulletin
      comment.created_by = User.current
      comment.save!
      present comment, with: Entities::CommentEntity
    end
  end
end

module V1
  class BulletinsAPI < Grape::API
    params do
      optional :group_id, type: String
      optional :before_id, type: String
      optional :limit, type: Integer, default: 25, values: 1..500
    end
    get 'bulletins.list' do
      if params[:group_id].nil?
        scope = User.current.bulletins
      else
        group = Group.find(params[:group_id])
        authorize group, :show?
        scope = group.bulletins
      end
      scope = scope.before_id(params[:before_id]) unless params[:before_id].nil?
      bulletins = scope.order(id: :desc).limit(params[:limit]).includes(
        :group, :created_by, :current_stamp, created_by: :avatar)
      present bulletins, with: Entities::BulletinEntity
    end

    params do
      requires :group_id, type: String
      optional :text, type: String
    end
    post 'bulletins.create' do
      group = Group.find(params[:group_id])
      authorize group, :admin?
      safe_params = ActionController::Parameters.new(params).permit(:text)
      bulletin = Bulletin.new(safe_params)
      bulletin.group = group
      bulletin.created_by = User.current
      bulletin.save!
      present bulletin, with: Entities::BulletinEntity
    end

    params do
      requires :id, type: String
      requires :symbol, type: Symbol, values: [:check, :cross]
    end
    post 'bulletins.stamp' do
      bulletin = Bulletin.find(params[:id])
      authorize bulletin.group, :show?
      Stamp.destroy_all(bulletin: bulletin, created_by: User.current)
      stamp = Stamp.new(symbol: params[:symbol])
      stamp.bulletin = bulletin
      stamp.created_by = User.current
      stamp.save!
      bulletin.reload
      present bulletin, with: Entities::BulletinEntity
    end
  end
end

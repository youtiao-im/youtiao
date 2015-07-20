module V1
  class BulletinsAPI < Grape::API
    before do
      params[:id] = Bulletin.decrypt_id(params[:id]) if params.key?(:id)
      params[:before_id] = Bulletin.decrypt_id(params[:before_id]) if params.key?(:before_id)
      params[:group_id] = Group.decrypt_id(params[:group_id]) if params.key?(:group_id)
    end

    params do
      optional :group_id, type: String
      optional :before_id, type: String
      optional :limit, type: Integer, default: 25, values: 1..500
    end
    get 'bulletins.list' do
      if params.key?(:group_id)
        group = Group.find(params[:group_id])
        authorize group, :show?
        scope = group.bulletins
      else
        scope = User.current.bulletins
      end
      scope = scope.before_id(params[:before_id]) unless params[:before_id].nil?
      bulletins = scope.order(id: :desc).limit(params[:limit]).includes(
        :group, :created_by, :current_stamp,
        group: :current_membership, created_by: :avatar)
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
      Notifications::BulletinCreatedWorker.perform_async(bulletin.id)
      present bulletin, with: Entities::BulletinEntity
    end

    params do
      requires :id, type: String
      requires :symbol, type: Symbol, values: [:check, :cross]
    end
    post 'bulletins.stamp' do
      bulletin = Bulletin.find(params[:id])
      authorize bulletin.group, :show?
      stamp = bulletin.stamps.find_by_created_by_id(User.current.id)
      unless stamp.try(:symbol) == params[:symbol]
        stamp.try(:destroy)
        stamp = Stamp.new(symbol: params[:symbol])
        stamp.bulletin = bulletin
        stamp.created_by = User.current
        stamp.save!
        Notifications::BulletinStampedWorker.perform_async(
          bulletin.id, User.current.id, params[:symbol])
        bulletin.reload
      end
      present bulletin, with: Entities::BulletinEntity
    end
  end
end

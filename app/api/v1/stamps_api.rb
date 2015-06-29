module V1
  class StampsAPI < Grape::API
    params do
      requires :bulletin_id, type: String
      optional :before_id, type: String
      optional :limit, type: Integer, default: 25, values: 1..500
    end
    get 'stamps.list' do
      bulletin = Bulletin.find(params[:bulletin_id])
      authorize bulletin.group, :admin?
      scope = bulletin.stamps
      scope = scope.before_id(params[:before_id]) unless params[:before_id].nil?
      stamps = scope.order(id: :desc).limit(params[:limit]).includes(
        :created_by, created_by: :avatar)
      present stamps, with: Entities::StampEntity
    end
  end
end

module V1
  class StampsAPI < Grape::API
    before do
      params[:before_id] = Stamp.decrypt_id(params[:before_id]) if params.key?(:before_id)
      params[:bulletin_id] = Bulletin.decrypt_id(params[:bulletin_id]) if params.key?(:bulletin_id)
    end

    params do
      requires :bulletin_id, type: String
      optional :symbols, type: Array[Symbol], values: [:check, :cross]
      optional :before_id, type: String
      optional :limit, type: Integer, default: 25, values: 1..500
    end
    get 'stamps.list' do
      bulletin = Bulletin.find(params[:bulletin_id])
      authorize bulletin.group, :show?
      scope = bulletin.stamps
      scope = scope.where(symbol: params[:symbols]) unless params[:symbols].nil?
      scope = scope.before_id(params[:before_id]) unless params[:before_id].nil?
      stamps = scope.order(id: :desc).limit(params[:limit]).includes(
        :created_by, created_by: :avatar)
      present stamps, with: Entities::StampEntity
    end
  end
end

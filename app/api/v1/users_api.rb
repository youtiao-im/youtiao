module V1
  class UsersAPI < Grape::API
    before do
      params[:avatar_id] = Blob.decrypt_id(params[:avatar_id]) if params.key?(:avatar_id)
    end

    get 'user.info' do
      present User.current, with: Entities::UserEntity
    end

    params do
      optional :name, type: String
      optional :avatar_id, type: String
    end
    post 'user.update' do
      safe_params = ActionController::Parameters.new(params).permit(
        :name, :avatar_id)
      User.current.update!(safe_params)
      present User.current, with: Entities::UserEntity
    end
  end
end

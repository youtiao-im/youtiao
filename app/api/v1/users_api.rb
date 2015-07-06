module V1
  class UsersAPI < Grape::API
    before do
      params[:avatar_id] = Blob.decrypt_id(params[:avatar_id]) if params.key?(:avatar_id)
    end

    oauth2 false
    params do
      requires :email, type: String
      requires :password, type: String
      requires :name, type: String
    end
    post 'users.sign_up' do
      safe_params = ActionController::Parameters.new(params).permit(
        :email, :password, :name)
      user = User.new(safe_params)
      user.save!
      present user, with: Entities::UserEntity
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
      user = User.current
      user.update!(safe_params)
      present user, with: Entities::UserEntity
    end

    params do
      requires :password, type: String
      requires :new_password, type: String
    end
    post 'user.change_password' do
      user = User.current
      error!({ error: :incorrect_password }, 403) unless user.valid_password?(params[:password])
      user.update!(password: params[:new_password])
      user.access_tokens.delete_all
      present user, with: Entities::UserEntity
    end
  end
end

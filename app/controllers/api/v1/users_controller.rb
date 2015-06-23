class Api::V1::UsersController < Api::V1::ApiController
  decorates_assigned :user

  def show
    @user = current_resource_owner
  end

  def update
    @user = current_resource_owner
    @user.update(safe_update_params)
    render :show
  end

  private

  def safe_update_params
    unless params[:avatar_id].nil?
      params[:avatar_id] = Blob.decrypt_id(params[:avatar_id])
    end
    params.permit(:name, :avatar_id)
  end
end

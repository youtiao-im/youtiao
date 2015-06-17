class Api::V1::UsersController < Api::V1::ApiController
  decorates_assigned :user

  def show
    @user = current_resource_owner
  end
end

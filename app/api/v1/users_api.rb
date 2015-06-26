module V1
  class UsersAPI < Grape::API
    get 'users.current' do
      present User.current, with: Entities::UserEntity
    end
  end
end

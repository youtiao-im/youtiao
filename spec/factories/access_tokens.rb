FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    resource_owner_id { FactoryGirl.create(:user).id }
    scopes ''
    expires_in 2.hours
    token { Faker::Internet.password(16) }
  end

  factory :expired_access_token, parent: :access_token,
          class: Doorkeeper::AccessToken do
    expires_in 0
  end
end

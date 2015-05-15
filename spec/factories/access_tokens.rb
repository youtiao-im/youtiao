FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    resource_owner_id { create(:user).id }
  end
end

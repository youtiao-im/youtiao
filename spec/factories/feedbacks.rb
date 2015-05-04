FactoryGirl.define do
  factory :feedback do
    post
    association :creator, factory: :user
  end
end

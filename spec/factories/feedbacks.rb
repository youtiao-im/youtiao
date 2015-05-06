FactoryGirl.define do
  factory :feedback do
    post
    sticker :check
    association :creator, factory: :user
  end
end

FactoryGirl.define do
  factory :feedback do
    feed
    sticker :check
    association :creator, factory: :user
  end
end

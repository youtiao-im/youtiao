FactoryGirl.define do
  factory :post do
    channel
    content { Faker::Hacker.say_something_smart }
    association :creator, factory: :user
  end
end

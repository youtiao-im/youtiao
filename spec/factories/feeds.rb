FactoryGirl.define do
  factory :feed do
    channel
    content { Faker::Hacker.say_something_smart }
    association :creator, factory: :user
  end

  factory :invalid_feed, parent: :feed, class: Feed do
    content nil
  end
end

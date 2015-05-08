FactoryGirl.define do
  factory :feed do
    channel
    association :creator, factory: :user
    content { Faker::Hacker.say_something_smart }
  end

  factory :invalid_feed, parent: :feed, class: Feed do
    content nil
  end
end

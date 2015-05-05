FactoryGirl.define do
  factory :post do
    channel
    content { Faker::Hacker.say_something_smart }
    association :creator, factory: :user
  end

  factory :invalid_post, parent: :post, class: Post do
    content nil
  end
end

FactoryGirl.define do
  factory :channel do
    name { Faker::Lorem.word }
  end

  factory :invalid_channel, parent: :channel, class: Channel do
    name nil
  end
end

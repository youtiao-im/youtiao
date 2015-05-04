FactoryGirl.define do
  factory :channel do
    name { Faker::Lorem.word }
  end
end

# == Schema Information
#
# Table name: channels
#
#  id            :integer          not null, primary key
#  created_by_id :integer          not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :channel do
    association :created_by, factory: :user
    name { Faker::Lorem.word }
  end

  factory :invalid_channel, parent: :channel, class: Channel do
    name nil
  end
end

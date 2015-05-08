# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  creator_id :integer          not null
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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

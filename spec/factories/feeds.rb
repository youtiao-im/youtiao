# == Schema Information
#
# Table name: feeds
#
#  id              :integer          not null, primary key
#  channel_id      :integer          not null
#  text            :string           not null
#  created_by_id   :integer          not null
#  checks_count    :integer          default(0), not null
#  crosses_count   :integer          default(0), not null
#  questions_count :integer          default(0), not null
#  comments_count  :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :feed do
    channel
    text { Faker::Hacker.say_something_smart }
    association :created_by, factory: :user
  end

  factory :invalid_feed, parent: :feed, class: Feed do
    text nil
  end
end

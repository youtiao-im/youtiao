# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  text       :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :attachment do
    feed
    text { Faker::Hacker.say_something_smart }
    url { Faker::Internet.url }
  end
end

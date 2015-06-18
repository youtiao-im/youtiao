# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  bulletin_id   :integer          not null
#  text          :string           not null
#  created_by_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    bulletin
    text { Faker::Hacker.say_something_smart }
    association :created_by, factory: :user
  end

  factory :invalid_comment, parent: :comment, class: Comment do
    text nil
  end
end

# == Schema Information
#
# Table name: bulletins
#
#  id             :integer          not null, primary key
#  group_id       :integer          not null
#  text           :string           not null
#  created_by_id  :integer          not null
#  checks_count   :integer          default(0), not null
#  crosses_count  :integer          default(0), not null
#  comments_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :bulletin do
    group
    text { Faker::Hacker.say_something_smart }
    association :created_by, factory: :user
  end

  factory :invalid_bulletin, parent: :bulletin, class: Bulletin do
    text nil
  end
end

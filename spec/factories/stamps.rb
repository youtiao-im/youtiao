# == Schema Information
#
# Table name: stamps
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  user_id    :integer          not null
#  kind       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :stamp do
    feed
    user
  end

  factory :check_stamp, parent: :stamp, class: Stamp do
    kind :check
  end

  factory :cross_stamp, parent: :stamp, class: Stamp do
    kind :cross
  end

  factory :question_stamp, parent: :stamp, class: Stamp do
    kind :question
  end
end

# == Schema Information
#
# Table name: marks
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  user_id    :integer          not null
#  symbol     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :mark do
    feed
    user
    symbol :check
  end

  factory :invalid_mark, parent: :mark, class: Mark do
    symbol :invalid
  end

  factory :check_mark, parent: :mark, class: Mark do
    symbol :check
  end

  factory :cross_mark, parent: :mark, class: Mark do
    symbol :cross
  end

  factory :question_mark, parent: :mark, class: Mark do
    symbol :question
  end
end

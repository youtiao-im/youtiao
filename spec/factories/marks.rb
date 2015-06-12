# == Schema Information
#
# Table name: marks
#
#  id              :integer          not null, primary key
#  bulletin_id     :integer          not null
#  symbol          :string           not null
#  created_by_id   :integer          not null
#  created_by_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :mark do
    bulletin
    association :created_by, factory: :membership
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
end

# == Schema Information
#
# Table name: stamps
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
  factory :stamp do
    bulletin
    association :created_by, factory: :membership
    symbol :check
  end

  factory :invalid_stamp, parent: :stamp, class: Stamp do
    symbol :invalid
  end

  factory :check_stamp, parent: :stamp, class: Stamp do
    symbol :check
  end

  factory :cross_stamp, parent: :stamp, class: Stamp do
    symbol :cross
  end
end

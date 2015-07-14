# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  code              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by_id     :integer          not null
#  memberships_count :integer          default(0), not null
#

FactoryGirl.define do
  factory :group do
    name { Faker::Name.name }
    association :created_by, factory: :user
  end

  factory :invalid_group, parent: :group, class: Group do
    name 'a'
  end
end

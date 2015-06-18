# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :membership do
    group
    user
    role :member
  end

  factory :owner_membership, parent: :membership, class: Membership do
    role :owner
  end

  factory :admin_membership, parent: :membership, class: Membership do
    role :admin
  end
end

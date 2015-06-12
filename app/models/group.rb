# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  memberships_count :integer          default(0), not null
#

class Group < ActiveRecord::Base
  has_many :memberships
  has_many :bulletins
  has_one :current_membership, -> { where(user_id: User.current.id) },
          class_name: 'Membership'
end

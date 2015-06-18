# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by_id     :integer          not null
#  memberships_count :integer          default(0), not null
#

class Group < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  has_many :memberships
  has_many :bulletins
  has_one :current_membership, -> { where(user_id: User.current.id) },
          class_name: 'Membership'

  validates :name, presence: true
end

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

class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :role, presence: true

  extend Enumerize
  enumerize :role, in: [:owner, :admin, :member], predicates: true

  counter_culture :group

  scope :before_id, -> (id) { where('memberships.id<?', id) }
end

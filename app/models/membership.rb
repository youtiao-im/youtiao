# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  alias      :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  extend Enumerize
  enumerize :role, in: [:owner, :admin, :member], predicates: true

  counter_culture :group
  acts_as_paranoid

  scope :before_id, -> (id) { where('memberships.id<?', id) }
end

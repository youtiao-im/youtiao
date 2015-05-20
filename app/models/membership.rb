# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Membership < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user

  extend Enumerize
  enumerize :role, in: [:owner, :admin, :member], predicates: true

  validates :role, presence: true

  counter_culture :channel

  def self.pinpoint(channel_id, user_id)
    membership = find_by_channel_id_and_user_id(channel_id, user_id)
    fail ActiveRecord::RecordNotFound if membership.nil?
    membership
  end
end

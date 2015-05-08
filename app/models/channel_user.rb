# == Schema Information
#
# Table name: channel_users
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChannelUser < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user

  extend Enumerize
  enumerize :role, in: [:owner, :admin, :member], predicates: true

  validates :role, presence: true

  def primary_admin_access?
    owner?
  end

  def admin_access?
    owner? || admin?
  end
end

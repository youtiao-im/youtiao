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

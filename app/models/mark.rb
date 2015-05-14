# == Schema Information
#
# Table name: marks
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  user_id    :integer          not null
#  symbol     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mark < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  extend Enumerize
  enumerize :symbol, in: [:check, :cross, :question], predicates: true

  validates :symbol, presence: true

  def self.pinpoint(feed_id, user_id)
    membership = find_by_feed_id_and_user_id(feed_id, user_id)
    fail ActiveRecord::RecordNotFound if membership.nil?
    membership
  end
end

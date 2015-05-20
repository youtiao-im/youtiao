# == Schema Information
#
# Table name: stars
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Star < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  counter_culture :feed

  def self.pinpoint(feed_id, user_id)
    star = find_by_feed_id_and_user_id(feed_id, user_id)
    fail ActiveRecord::RecordNotFound if star.nil?
    star
  end
end

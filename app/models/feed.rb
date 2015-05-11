# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  creator_id :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feed < ActiveRecord::Base
  belongs_to :channel
  belongs_to :creator, class_name: 'User'
  has_many :attachments
  has_many :stamps

  validates :text, presence: true

  def stamp(user)
    stamps.find_by_user_id(user.id)
  end
end

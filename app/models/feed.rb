# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  creator_id :integer          not null
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feed < ActiveRecord::Base
  belongs_to :channel
  belongs_to :creator, class_name: 'User'

  validates :content, presence: true
end

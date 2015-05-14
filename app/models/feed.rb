# == Schema Information
#
# Table name: feeds
#
#  id            :integer          not null, primary key
#  channel_id    :integer          not null
#  created_by_id :integer          not null
#  text          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Feed < ActiveRecord::Base
  belongs_to :channel
  belongs_to :created_by, class_name: 'User'
  has_many :attachments
  has_many :marks

  validates :text, presence: true
end

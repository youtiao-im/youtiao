class Feed < ActiveRecord::Base
  belongs_to :channel
  belongs_to :creator, class_name: 'User'

  validates :content, presence: true
end

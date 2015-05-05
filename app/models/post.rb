class Post < ActiveRecord::Base
  belongs_to :channel
  belongs_to :creator, class_name: 'User'
  has_many :feedbacks

  validates :content, presence: true
end

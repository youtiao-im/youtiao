class Feedback < ActiveRecord::Base
  belongs_to :post
  belongs_to :creator, class_name: 'User'
end

class Feedback < ActiveRecord::Base
  belongs_to :feed
  belongs_to :creator, class_name: 'User'

  extend Enumerize
  enumerize :sticker, in: [:cross, :check], default: :check, predicates: true
end

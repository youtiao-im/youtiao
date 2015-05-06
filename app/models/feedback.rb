class Feedback < ActiveRecord::Base
  extend Enumerize

  belongs_to :post
  belongs_to :creator, class_name: 'User'

  enumerize :sticker, in: [:cross, :check], default: :check,
            predicates: true
end

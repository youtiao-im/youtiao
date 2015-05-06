class ChannelUser < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user

  extend Enumerize
  enumerize :role, in: [:admin, :publisher, :subscriber], default: :subscriber, predicates: true
end

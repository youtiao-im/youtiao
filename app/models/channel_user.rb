class ChannelUser < ActiveRecord::Base
  extend Enumerize

  belongs_to :channel
  belongs_to :user

  enumerize :role, in: [:admin, :publisher, :subscriber], default: :subscriber,
            predicates: true
end

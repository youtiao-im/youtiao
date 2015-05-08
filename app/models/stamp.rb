class Stamp < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  extend Enumerize
  enumerize :kind, in: [:check, :cross, :question], predicates: true

  validates :kind, presence: true
end

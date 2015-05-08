# == Schema Information
#
# Table name: stamps
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  user_id    :integer          not null
#  kind       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Stamp < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  extend Enumerize
  enumerize :kind, in: [:check, :cross, :question], predicates: true

  validates :kind, presence: true
end

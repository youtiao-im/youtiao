# == Schema Information
#
# Table name: stamps
#
#  id            :integer          not null, primary key
#  bulletin_id   :integer          not null
#  symbol        :string           not null
#  created_by_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Stamp < ActiveRecord::Base
  belongs_to :bulletin
  belongs_to :created_by, class_name: 'User'

  validates :symbol, presence: true

  extend Enumerize
  enumerize :symbol, in: [:check, :cross, :eye], predicates: true

  counter_culture :bulletin, column_name: (lambda do |model|
    "#{model.symbol.pluralize}_count"
  end)

  scope :before_id, -> (id) { where('stamps.id<?', id) }
end

# == Schema Information
#
# Table name: channels
#
#  id            :integer          not null, primary key
#  created_by_id :integer          not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Channel < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  has_many :memberships
  has_many :feeds

  validates :name, presence: true
end

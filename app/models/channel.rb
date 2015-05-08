# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  creator_id :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Channel < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :channel_users
  has_many :users, through: :channel_users
  has_many :feeds

  validates :name, presence: true

  def channel_user(user)
    channel_users.find_by_user_id(user.id)
  end
end

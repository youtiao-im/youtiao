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

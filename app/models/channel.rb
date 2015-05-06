class Channel < ActiveRecord::Base
  has_many :channel_users
  has_many :users, through: :channel_users
  has_many :posts

  validates :name, presence: true

  def channel_user(user)
    channel_users.find_by_user_id(user.id)
  end
end

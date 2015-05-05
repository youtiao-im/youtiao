class Channel < ActiveRecord::Base
  has_many :channel_users
  has_many :users, through: :channel_users
  has_many :posts
  has_many :administrators, -> { where( "channel_users.role = 'admin'") }, through: :channel_users, source: :user
  has_many :subscribers, -> { where( "channel_users.role = 'subscriber'") }, through: :channel_users, source: :user

  def has_user?(user)
    !channel_user(user).nil?
  end

  def channel_user(user)
    channel_users.each do |channel_user|
      if channel_user.user_id == user.id
        return channel_user
      end
    end
    nil
  end

  def is_channel_publisher?(user)
    channel_users.each do |channel_user|
      if channel_user.user_id == user.id && channel_user.role == 'publisher'
        return true
      end
    end
    false
  end
end

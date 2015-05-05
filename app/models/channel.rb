class Channel < ActiveRecord::Base
  has_many :channel_users
  has_many :users, through: :channel_users
  has_many :posts
  has_many :administrators, -> { where( "channel_users.role = 'admin'") }, through: :channel_users, source: :user
  has_many :subscribers, -> { where( "channel_users.role = 'subscriber'") }, through: :channel_users, source: :user
end

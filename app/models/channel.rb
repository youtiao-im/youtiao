class Channel < ActiveRecord::Base
  has_many :channel_users
  has_many :users, through: :channel_users
  has_many :channel_admins, -> { where(role: :admin) },
    class_name: 'ChannelUser'
  has_many :admins, through: :channel_admins, source: :user
  has_many :channel_publishers, -> { where(role: [:publisher, :admin]) },
    class_name: 'ChannelUser'
  has_many :publishers, through: :channel_publishers, source: :user
  has_many :posts

  validates :name, presence: true
end

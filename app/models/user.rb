class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :channel_users
  has_many :channels, through: :channel_users
  has_many :posts, as: :creator
  has_many :feedbacks, as: :creator

  attr_accessor :current_channel
end

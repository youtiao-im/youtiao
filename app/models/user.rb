# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  name                   :string           not null
#  avatar_id              :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  belongs_to :avatar, class_name: 'Blob'
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :bulletins, through: :groups
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 32 },
            format: %r{\A(?!.*?[\\\/:\*\?\/"<>\|@#])[[:print:]]+\z}

  def self.current
    RequestStore.store[:current_user]
  end

  def self.current=(user)
    RequestStore.store[:current_user] = user
  end
end

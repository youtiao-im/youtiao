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

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to :avatar }
  it { should have_many :memberships }
  it { should have_many(:groups).through(:memberships) }
  it { should have_many(:bulletins).through(:groups) }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(32) }
end

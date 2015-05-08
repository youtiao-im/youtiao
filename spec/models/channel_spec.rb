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

require 'rails_helper'

RSpec.describe Channel, type: :model do
  it { should belong_to :creator }
  it { should have_many :channel_users }
  it { should have_many(:users).through(:channel_users) }
  it { should have_many :feeds }
end

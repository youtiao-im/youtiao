require 'rails_helper'

RSpec.describe Channel, type: :model do
  it { should belong_to :creator }
  it { should have_many :channel_users }
  it { should have_many(:users).through(:channel_users) }
  it { should have_many :feeds }
end

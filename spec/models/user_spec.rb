require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :channel_users }
  it { should have_many(:channels).through(:channel_users) }
end

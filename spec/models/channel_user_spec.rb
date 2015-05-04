require 'rails_helper'

RSpec.describe ChannelUser, type: :model do
  it { should belong_to :channel }
  it { should belong_to :user }
end

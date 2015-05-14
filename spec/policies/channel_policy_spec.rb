require 'rails_helper'

RSpec.describe ChannelPolicy, type: :policy do
  subject { ChannelPolicy.new(user, channel) }
  let(:user) { FactoryGirl.create(:user) }

  context 'for a user not affiliated with channel' do
    let(:channel) { FactoryGirl.create(:channel) }

    it { should_not authorize(:show) }
    it { should authorize(:create) }
    it { should_not authorize(:admin) }
  end

  context 'for a user affiliated with channel' do
    let(:channel) { FactoryGirl.create(:channel) }

    before do
      FactoryGirl.create(:membership, channel: channel, user: user)
    end

    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should_not authorize(:admin) }
  end

  context 'for a channel admin' do
    let(:channel) { FactoryGirl.create(:channel) }

    before do
      FactoryGirl.create(:admin_membership, channel: channel, user: user)
    end

    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:admin) }
  end
end

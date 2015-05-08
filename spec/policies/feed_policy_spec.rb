require 'rails_helper'

RSpec.describe FeedPolicy, type: :policy do
  subject { FeedPolicy.new(user, record) }

  before do
    user.current_channel = record.channel
  end

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  context 'for a user not in the channel' do
    let(:record) { FactoryGirl.create(:feed) }
    let(:user) { FactoryGirl.create(:user) }

    it { should_not authorize(:index) }
    it { should_not authorize(:show) }
    it { should_not authorize(:create) }
    it { should_not authorize(:stamp) }
  end

  context 'for a channel member' do
    let(:record) { FactoryGirl.create(:feed) }
    let(:user) { FactoryGirl.create(:channel_member, channel: record.channel).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should_not authorize(:create) }
    it { should authorize(:stamp) }
  end

  context 'for a channel admin' do
    let(:record) { FactoryGirl.create(:feed) }
    let(:user) { FactoryGirl.create(:channel_admin, channel: record.channel).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:stamp) }
  end

  context 'for a channel owner' do
    let(:record) { FactoryGirl.create(:feed) }
    let(:user) { FactoryGirl.create(:channel_owner, channel: record.channel).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:stamp) }
  end
end

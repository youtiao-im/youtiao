require 'rails_helper'

RSpec.describe ChannelPolicy, type: :policy do
  subject { ChannelPolicy.new(user, record) }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  context 'for a user not in the channel' do
    let(:record) { FactoryGirl.create(:channel) }
    let(:user) { FactoryGirl.create(:user) }

    it { should authorize(:index) }
    it { should_not authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:join) }
  end

  context 'for a channel member' do
    let(:record) { FactoryGirl.create(:channel) }
    let(:user) { FactoryGirl.create(:channel_member, channel: record).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:join) }
  end
end

require 'rails_helper'

RSpec.describe ChannelPolicy, type: :policy do
  subject { ChannelPolicy.new(user, record) }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  context 'for not a channel user' do
    let(:record) { FactoryGirl.create(:channel) }
    let(:user) { FactoryGirl.create(:user) }

    it { should authorize(:index) }
    it { should_not authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:subscribe) }
  end

  context 'for a channel user' do
    let(:record) { FactoryGirl.create(:channel) }
    let(:user) { FactoryGirl.create(:channel_user, channel: record).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:subscribe) }
  end
end

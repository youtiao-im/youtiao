require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { PostPolicy.new(user, record) }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  context 'for not a channel user' do
    let(:record) { FactoryGirl.create(:post) }
    let(:user) { FactoryGirl.create(:user) }

    it { should_not authorize(:index) }
    it { should_not authorize(:show) }
    it { should_not authorize(:create) }
    it { should_not authorize(:feedback) }
  end

  context 'for a channel subscriber' do
    let(:record) { FactoryGirl.create(:post) }
    let(:user) { FactoryGirl.create(:channel_subscriber, channel: record.channel).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should_not authorize(:create) }
    it { should authorize(:feedback) }
  end

  context 'for a channel publisher' do
    let(:record) { FactoryGirl.create(:post) }
    let(:user) { FactoryGirl.create(:channel_publisher, channel: record.channel).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:feedback) }
  end

  context 'for a channel admin' do
    let(:record) { FactoryGirl.create(:post) }
    let(:user) { FactoryGirl.create(:channel_admin, channel: record.channel).user }

    it { should authorize(:index) }
    it { should authorize(:show) }
    it { should authorize(:create) }
    it { should authorize(:feedback) }
  end
end

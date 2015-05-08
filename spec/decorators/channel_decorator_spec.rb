require 'rails_helper'

RSpec.describe ChannelDecorator, type: :decorator do
  subject { channel.decorate(context: { current_user: user }) }
  let(:channel) { FactoryGirl.create(:channel) }
  let(:user) { FactoryGirl.create(:user) }

  describe '#creator_id' do
    it 'returns id of creator' do
      expect(subject.creator_id).to eq(channel.creator.to_param)
    end
  end

  describe '#owner?' do
    context 'when user has not joined the channel' do
      it 'returns false' do
        expect(subject.owner?).to be_falsey
      end
    end

    context 'when user is not an owner of the channel' do
      it 'returns false' do
        FactoryGirl.create(:channel_admin, channel: channel, user: user)
        expect(subject.owner?).to be_falsey
      end
    end

    context 'when user is an owner of the channel' do
      it 'returns true' do
        FactoryGirl.create(:channel_owner, channel: channel, user: user)
        expect(subject.owner?).to be_truthy
      end
    end
  end

  describe '#admin?' do
    context 'when user has not joined the channel' do
      it 'returns false' do
        expect(subject.admin?).to be_falsey
      end
    end

    context 'when user is not an admin of the channel' do
      it 'returns false' do
        FactoryGirl.create(:channel_owner, channel: channel, user: user)
        expect(subject.admin?).to be_falsey
      end
    end

    context 'when user is an admin of the channel' do
      it 'returns true' do
        FactoryGirl.create(:channel_admin, channel: channel, user: user)
        expect(subject.admin?).to be_truthy
      end
    end
  end

  describe '#owner_ids' do
    it 'returns ids of all owners of the channel' do
      FactoryGirl.create(:channel_owner, channel: channel, user: user)
      expect(subject.owner_ids).to match_array([user.to_param])
    end
  end

  describe '#admin_ids' do
    it 'returns ids of all admins of the channel' do
      FactoryGirl.create(:channel_admin, channel: channel, user: user)
      expect(subject.admin_ids).to match_array([user.to_param])
    end
  end

  describe '#member_ids' do
    it 'returns ids of all members of the channel' do
      FactoryGirl.create(:channel_member, channel: channel, user: user)
      expect(subject.member_ids).to match_array([user.to_param])
    end
  end
end

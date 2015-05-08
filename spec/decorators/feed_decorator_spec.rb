require 'rails_helper'

RSpec.describe FeedDecorator, type: :decorator do
  subject { feed.decorate(context: { current_user: user }) }
  let(:feed) { FactoryGirl.create(:feed) }
  let(:user) { FactoryGirl.create(:user) }

  describe '#checked?' do
    context 'when user has not stamped the feed' do
      it 'returns false' do
        expect(subject.checked?).to be_falsey
      end
    end

    context 'when user has not checked the feed' do
      it 'returns false' do
        FactoryGirl.create(:cross_stamp, feed: feed, user: user)
        expect(subject.checked?).to be_falsey
      end
    end

    context 'when user has checked the feed' do
      it 'returns true' do
        FactoryGirl.create(:check_stamp, feed: feed, user: user)
        expect(subject.checked?).to be_truthy
      end
    end
  end

  describe '#crossed?' do
    context 'when user has not stamped the feed' do
      it 'returns false' do
        expect(subject.crossed?).to be_falsey
      end
    end

    context 'when user has not crossed the feed' do
      it 'returns false' do
        FactoryGirl.create(:question_stamp, feed: feed, user: user)
        expect(subject.crossed?).to be_falsey
      end
    end

    context 'when user has crossed the feed' do
      it 'returns true' do
        FactoryGirl.create(:cross_stamp, feed: feed, user: user)
        expect(subject.crossed?).to be_truthy
      end
    end
  end

  describe '#questioned?' do
    context 'when user has not stamped the feed' do
      it 'returns false' do
        expect(subject.questioned?).to be_falsey
      end
    end

    context 'when user has not questioned the feed' do
      it 'returns false' do
        FactoryGirl.create(:check_stamp, feed: feed, user: user)
        expect(subject.questioned?).to be_falsey
      end
    end

    context 'when user has questioned the feed' do
      it 'returns true' do
        FactoryGirl.create(:question_stamp, feed: feed, user: user)
        expect(subject.questioned?).to be_truthy
      end
    end
  end

  describe '#checked_by_ids' do
    it 'returns ids of all users checked the feed' do
      FactoryGirl.create(:check_stamp, feed: feed, user: user)
      expect(subject.checked_by_ids).to match_array([user.id])
    end
  end

  describe '#crossed_by_ids' do
    it 'returns ids of all users crossed the feed' do
      FactoryGirl.create(:cross_stamp, feed: feed, user: user)
      expect(subject.crossed_by_ids).to match_array([user.id])
    end
  end

  describe '#questioned_by_ids' do
    it 'returns ids of all users qustioned the feed' do
      FactoryGirl.create(:question_stamp, feed: feed, user: user)
      expect(subject.questioned_by_ids).to match_array([user.id])
    end
  end
end

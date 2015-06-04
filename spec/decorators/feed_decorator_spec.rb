require 'rails_helper'

RSpec.describe FeedDecorator, type: :decorator do
  subject { feed.decorate }
  let(:feed) { create(:feed) }
  let(:user) { create(:user) }

  before do
    User.current = user
  end

  describe '#mark' do
    context 'when feed is not marked by user' do
      it 'returns nil' do
        expect(subject.mark).to be_nil
      end
    end

    context 'when feed is marked by user' do
      it 'returns the mark decorated' do
        mark = create(:mark, feed: feed, user: user)
        expect(subject.mark).to be_decorated
        expect(subject.mark).to eq(mark)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::AuthenticatedUsers::FeedsController,
               type: :controller do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

  before do
    create(:membership, channel: channel, user: user)
  end

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      it 'responds with :ok' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'decorates feeds to user as #feeds' do
        feed = create(:feed, channel: channel)
        get :index
        expect(controller.feeds).to be_decorated
        expect(controller.feeds).to match_array([feed])
      end

      it 'sets pagination headers' do
        get :index
        expect(response.headers['X-Total']).to_not be_nil
        expect(response.headers['X-Per-Page']).to_not be_nil
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  describe 'GET #index' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        use_invalid_token
        get :index, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        use_valid_token
        get :index, channel_id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for a channel user not joined' do
      it 'responds with :forbidden' do
        channel = FactoryGirl.create(:channel)
        use_valid_token
        get :index, channel_id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a channel user joined' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
        get :index, channel_id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'decorates all feeds of the channel as #feeds' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        get :index, channel_id: channel.to_param
        expect(controller.feeds).to be_decorated
        expect(controller.feeds).to match_array([feed])
      end
    end
  end

  describe 'GET #show' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        use_invalid_token
        get :show, channel_id: 0, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing feed' do
      it 'responds with :not_found' do
        use_valid_token
        get :show, channel_id: 0, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for a feed from a channel user not joined' do
      it 'responds with :forbidden' do
        feed = FactoryGirl.create(:feed)
        use_valid_token
        get :show, channel_id: feed.channel.to_param, id: feed.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a feed from a channel user joined' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        get :show, channel_id: feed.channel.to_param, id: feed.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'decorates the feed as #feed' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        get :show, channel_id: feed.channel.to_param, id: feed.to_param
        expect(controller.feed).to be_decorated
        expect(controller.feed).to eq(feed)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_params) { FactoryGirl.build(:feed).attributes }
    let(:invalid_params) { FactoryGirl.build(:invalid_feed).attributes }

    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        use_invalid_token
        post :create, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        use_valid_token
        post :create, channel_id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for a channel user not joined' do
      it 'responds with :forbidden' do
        channel = FactoryGirl.create(:channel)
        use_valid_token
        post :create, channel_id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a channel user is not an admin' do
      it 'responds with :forbidden' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
        post :create, channel_id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with invalid parameters' do
      it 'responds with :bad_request' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_admin, user: user).channel
        use_valid_token_for user
        post :create, invalid_params.merge(channel_id: channel.to_param)
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with valid parameters' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_admin, user: user).channel
        use_valid_token_for user
        post :create, valid_params.merge(channel_id: channel.to_param)
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new feed' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_admin, user: user).channel
        use_valid_token_for user
        expect do
          post :create, valid_params.merge(channel_id: channel.to_param)
        end.to change(Feed, :count).by(1)
      end

      it 'decorates the new feed as #feed' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_admin, user: user).channel
        use_valid_token_for user
        post :create, valid_params.merge(channel_id: channel.to_param)
        expect(controller.feed).to be_decorated
        expect(controller.feed).to eq(Feed.last)
      end
    end
  end

  describe 'POST #stamp' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        use_invalid_token
        post :stamp, channel_id: 0, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing post' do
      it 'responds with :not_found' do
        use_valid_token
        post :stamp, channel_id: 0, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for a feed from a channel user not joined' do
      it 'responds with :forbidden' do
        feed = FactoryGirl.create(:feed)
        use_valid_token
        post :stamp, channel_id: feed.channel.to_param, id: feed.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when user stamps the first time' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :cross
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new stamp' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        expect do
          post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :cross
        end.to change(Stamp, :count).by(1)
      end
    end

    context 'when user stamps again' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :check
        post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :cross
        expect(response).to have_http_status(:ok)
      end

      it 'does not create any new stamp' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :check
        expect do
          post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :cross
        end.to_not change(Stamp, :count)
      end

      it 'updates the existing stamp with the new data' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel)
        use_valid_token_for user
        post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :check
        post :stamp, channel_id: feed.channel.to_param, id: feed.to_param, kind: :cross
        expect(Stamp.last.kind).to eq(:cross)
      end
    end
  end
end

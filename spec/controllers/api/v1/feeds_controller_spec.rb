require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  describe 'GET #index' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        set_invalid_token
        get :index, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        set_valid_token
        get :index, channel_id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for not a channel user' do
      it 'responds with :forbidden' do
        channel = FactoryGirl.create(:channel)
        set_valid_token
        get :index, channel_id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a channel user' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        set_valid_token_for user
        get :index, channel_id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'decorates all feeds of the channel as #feeds' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        feed = FactoryGirl.create(:feed, channel: channel, creator: user)
        FactoryGirl.create(:feed)
        set_valid_token_for user
        get :index, channel_id: channel.to_param
        expect(controller.feeds).to be_decorated
        expect(controller.feeds).to match_array([feed])
      end
    end
  end

  describe 'GET #show' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        set_invalid_token
        get :show, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing feed' do
      it 'responds with :not_found' do
        set_valid_token
        get :show, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for not a channel user' do
      it 'responds with :forbidden' do
        feed = FactoryGirl.create(:feed)
        set_valid_token
        get :show, id: feed.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a channel user' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        set_valid_token_for user
        get :show, id: feed.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'decorates the feed as #feed' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        set_valid_token_for user
        get :show, id: feed.to_param
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
        set_invalid_token
        post :create, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        set_valid_token
        post :create, channel_id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for not a channel user' do
      it 'responds with :forbidden' do
        channel = FactoryGirl.create(:channel)
        set_valid_token
        post :create, channel_id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for not a channel publisher' do
      it 'responds with :forbidden' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_subscriber, user: user).channel
        set_valid_token_for user
        post :create, channel_id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with invalid parameters' do
      it 'responds with :bad_request' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_publisher, user: user).channel
        set_valid_token_for user
        post :create, invalid_params.merge(channel_id: channel.to_param)
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with valid parameters' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_publisher, user: user).channel
        set_valid_token_for user
        post :create, valid_params.merge(channel_id: channel.to_param)
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new feed' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_publisher, user: user).channel
        set_valid_token_for user
        expect do
          post :create, valid_params.merge(channel_id: channel.to_param)
        end.to change(Feed, :count).by(1)
      end

      it 'decorates the new feed as #feed' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_publisher, user: user).channel
        set_valid_token_for user
        post :create, valid_params.merge(channel_id: channel.to_param)
        expect(controller.feed).to be_decorated
        expect(controller.feed).to eq(Feed.last)
      end
    end
  end

  describe 'POST #feedback' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        set_invalid_token
        post :feedback, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing post' do
      it 'responds with :not_found' do
        set_valid_token
        post :feedback, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for not a channel user' do
      it 'responds with :forbidden' do
        feed = FactoryGirl.create(:feed)
        set_valid_token
        post :feedback, id: feed.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with empty :sticker parameter' do
      it 'responds with :bad_request' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        set_valid_token_for user
        post :feedback, id: feed.to_param, sticker: nil
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when feedback already exists' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        FactoryGirl.create(:feedback, feed: feed, creator: user)
        set_valid_token_for user
        post :feedback, id: feed.to_param, sticker: :check
        expect(response).to have_http_status(:ok)
      end

      it 'does not create any new feedback' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        FactoryGirl.create(:feedback, feed: feed, creator: user)
        set_valid_token_for user
        expect do
          post :feedback, id: feed.to_param, sticker: :check
        end.to_not change(Feedback, :count)
      end

      it 'updates the existing feedback with the new data' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        feedback = FactoryGirl.create(:feedback, feed: feed, creator: user)
        set_valid_token_for user
        post :feedback, id: feed.to_param, sticker: :cross
        expect(feedback.reload.sticker).to eq(:cross)
      end
    end

    context 'when feedback doest not exist' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        set_valid_token_for user
        post :feedback, id: feed.to_param, sticker: :check
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new feedback' do
        user = FactoryGirl.create(:user)
        feed = FactoryGirl.create(:feed)
        FactoryGirl.create(:channel_user, channel: feed.channel, user: user)
        set_valid_token_for user
        expect do
          post :feedback, id: feed.to_param, sticker: :check
        end.to change(Feedback, :count).by(1)
      end
    end
  end
end

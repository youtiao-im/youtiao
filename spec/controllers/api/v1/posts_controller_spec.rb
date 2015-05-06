require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
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

      it 'decorates all posts of the channel as #posts' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        post = FactoryGirl.create(:post, channel: channel, creator: user)
        FactoryGirl.create(:post)
        set_valid_token_for user
        get :index, channel_id: channel.to_param
        expect(controller.posts).to be_decorated
        expect(controller.posts).to match_array([post])
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

    context 'for a non-existing post' do
      it 'responds with :not_found' do
        set_valid_token
        get :show, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for not a channel user' do
      it 'responds with :forbidden' do
        channel = FactoryGirl.create(:channel)
        post = FactoryGirl.create(:post, channel: channel)
        set_valid_token
        get :show, id: post.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a channel user' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        post = FactoryGirl.create(:post, channel: channel, creator: user)
        set_valid_token_for user
        get :show, id: post.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'decorates the post as #post' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        post = FactoryGirl.create(:post, channel: channel, creator: user)
        set_valid_token_for user
        get :show, id: post.to_param
        expect(controller.post).to be_decorated
        expect(controller.post).to eq(post)
      end
    end
  end

  describe 'POST #create' do
    let(:params) { FactoryGirl.build(:post).attributes }
    let(:invalid_params) { FactoryGirl.build(:invalid_post).attributes }

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
        set_valid_token_for user
        channel = FactoryGirl.create(:channel_subscriber, user: user).channel
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
        post :create, params.merge(channel_id: channel.to_param)
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new post' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_publisher, user: user).channel
        set_valid_token_for user
        expect do
          post :create, params.merge(channel_id: channel.to_param)
        end.to change(Post, :count).by(1)
      end

      it 'decorates the new post as #post' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_publisher, user: user).channel
        set_valid_token_for user
        post :create, params.merge(channel_id: channel.to_param)
        expect(controller.post).to be_decorated
        expect(controller.post).to eq(Post.last)
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
        a_post = FactoryGirl.create(:post)
        set_valid_token
        post :feedback, id: a_post.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with invalid parameters' do
      it 'responds with :bad_request' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        channel_post = FactoryGirl.create(:post, channel: channel)
        set_valid_token_for user
        post :feedback, id: channel_post.to_param, sticker: nil
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when feedback already exists' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        channel_post = FactoryGirl.create(:post, channel: channel)
        FactoryGirl.create(:feedback, post: channel_post, creator: user)
        set_valid_token_for user
        post :feedback, id: channel_post.to_param, sticker: :check
        expect(response).to have_http_status(:ok)
      end

      it 'does not create any new feedback' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        channel_post = FactoryGirl.create(:post, channel: channel)
        FactoryGirl.create(:feedback, post: channel_post, creator: user)
        set_valid_token_for user
        expect do
          post :feedback, id: channel_post.to_param, sticker: :check
        end.to_not change(Feedback, :count)
      end

      it 'updates the existing feedback with the new data' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        channel_post = FactoryGirl.create(:post, channel: channel)
        feedback = FactoryGirl.create(:feedback, post: channel_post, creator: user)
        set_valid_token_for user
        post :feedback, id: channel_post.to_param, sticker: :cross
        expect(feedback.reload.sticker).to eq(:cross)
      end
    end

    context 'when feedback doest not exist' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        channel_post = FactoryGirl.create(:post, channel: channel)
        set_valid_token_for user
        post :feedback, id: channel_post.to_param, sticker: :check
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new feedback' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        channel_post = FactoryGirl.create(:post, channel: channel)
        set_valid_token_for user
        expect do
          post :feedback, id: channel_post.to_param, sticker: :check
        end.to change(Feedback, :count).by(1)
      end
    end
  end
end

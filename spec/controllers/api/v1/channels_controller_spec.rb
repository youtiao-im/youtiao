require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  describe 'GET #index' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        set_invalid_token
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when access token is valid' do
      it 'responds with :ok' do
        set_valid_token
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'decorates all channels user subscribed as #channels' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        FactoryGirl.create(:channel)
        set_valid_token_for user
        get :index
        expect(controller.channels).to be_decorated
        expect(controller.channels).to match_array([channel])
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

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        set_valid_token
        get :show, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for not a channel user' do
      it 'responds with :forbidden' do
        channel = FactoryGirl.create(:channel)
        set_valid_token
        get :show, id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a channel user' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        set_valid_token_for user
        get :show, id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'decorates the channel as #channel' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        set_valid_token_for user
        get :show, id: channel.to_param
        expect(controller.channel).to be_decorated
        expect(controller.channel).to eq(channel)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_params) { FactoryGirl.build(:channel).attributes }
    let(:invalid_params) { FactoryGirl.build(:invalid_channel).attributes }

    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        set_invalid_token
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid parameters' do
      it 'responds with :bad_request' do
        set_valid_token
        post :create, invalid_params
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with valid parameters' do
      it 'responds with :ok' do
        set_valid_token
        post :create, valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new channel' do
        set_valid_token
        expect do
          post :create, valid_params
        end.to change(Channel, :count).by(1)
      end

      it 'adds user to the new channel as an admin' do
        user = FactoryGirl.create(:user)
        set_valid_token_for user
        post :create, valid_params
        expect(Channel.last.channel_user(user).admin?).to be_truthy
      end

      it 'decorates the new channel as #channel' do
        set_valid_token
        post :create, valid_params
        expect(controller.channel).to be_decorated
        expect(controller.channel).to eq(Channel.last)
      end
    end
  end

  describe 'POST #subscribe' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        set_invalid_token
        post :subscribe, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        set_valid_token
        post :subscribe, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for a channel user' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        set_valid_token_for user
        post :subscribe, id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'does not create any new channel user' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        set_valid_token_for user
        expect do
          post :subscribe, id: channel.to_param
        end.to_not change(ChannelUser, :count)
      end

      it 'decorates the channel as #channel' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_user, user: user).channel
        set_valid_token_for user
        post :subscribe, id: channel.to_param
        expect(controller.channel).to be_decorated
        expect(controller.channel).to eq(channel)
      end
    end

    context 'for not a channel user' do
      it 'responds with :ok' do
        channel = FactoryGirl.create(:channel)
        set_valid_token
        post :subscribe, id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new channel user' do
        channel = FactoryGirl.create(:channel)
        set_valid_token
        expect do
          post :subscribe, id: channel.to_param
        end.to change(ChannelUser, :count).by(1)
      end

      it 'adds user to the channel as a subscriber' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel)
        set_valid_token_for user
        post :subscribe, id: channel.to_param
        expect(channel.channel_user(user).subscriber?).to be_truthy
      end

      it 'decorates the channel as #channel' do
        channel = FactoryGirl.create(:channel)
        set_valid_token
        post :subscribe, id: channel.to_param
        expect(controller.channel).to be_decorated
        expect(controller.channel).to eq(channel)
      end
    end
  end
end

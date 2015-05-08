require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  describe 'GET #index' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        use_invalid_token
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when access token is valid' do
      it 'responds with :ok' do
        use_valid_token
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'decorates all channels user joined as #channels' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
        get :index
        expect(controller.channels).to be_decorated
        expect(controller.channels).to match_array([channel])
      end

      it 'sets pagination headers' do
        user = FactoryGirl.create(:user)
        FactoryGirl.create(:channel_member, user: user)
        use_valid_token_for user
        get :index
        expect(response.headers['Total']).to eq('1')
        expect(response.headers['Per-Page']).to eq('25')
      end
    end
  end

  describe 'GET #show' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        use_invalid_token
        get :show, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        use_valid_token
        get :show, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for a channel user not joined' do
      it 'responds with :forbidden' do
        channel = FactoryGirl.create(:channel)
        use_valid_token
        get :show, id: channel.to_param
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'for a channel user joined' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
        get :show, id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'decorates the channel as #channel' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
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
        use_invalid_token
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid parameters' do
      it 'responds with :bad_request' do
        use_valid_token
        post :create, invalid_params
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with valid parameters' do
      it 'responds with :ok' do
        use_valid_token
        post :create, valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new channel' do
        use_valid_token
        expect do
          post :create, valid_params
        end.to change(Channel, :count).by(1)
      end

      it 'adds user to the new channel as an owner' do
        user = FactoryGirl.create(:user)
        use_valid_token_for user
        post :create, valid_params
        expect(Channel.last.channel_user(user).owner?).to be_truthy
      end

      it 'decorates the new channel as #channel' do
        use_valid_token
        post :create, valid_params
        expect(controller.channel).to be_decorated
        expect(controller.channel).to eq(Channel.last)
      end
    end
  end

  describe 'POST #join' do
    context 'when access token is invalid' do
      it 'responds with :unauthorized' do
        use_invalid_token
        post :join, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found' do
        use_valid_token
        post :join, id: 0
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'for a channel user already joined' do
      it 'responds with :ok' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
        post :join, id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'does not create any new ChannelUser record' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
        expect do
          post :join, id: channel.to_param
        end.to_not change(ChannelUser, :count)
      end

      it 'decorates the channel as #channel' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel_member, user: user).channel
        use_valid_token_for user
        post :join, id: channel.to_param
        expect(controller.channel).to be_decorated
        expect(controller.channel).to eq(channel)
      end
    end

    context 'for a channel user not joined' do
      it 'responds with :ok' do
        channel = FactoryGirl.create(:channel)
        use_valid_token
        post :join, id: channel.to_param
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new ChannelUser record' do
        channel = FactoryGirl.create(:channel)
        use_valid_token
        expect do
          post :join, id: channel.to_param
        end.to change(ChannelUser, :count).by(1)
      end

      it 'adds user to the channel as a member' do
        user = FactoryGirl.create(:user)
        channel = FactoryGirl.create(:channel)
        use_valid_token_for user
        post :join, id: channel.to_param
        expect(channel.channel_user(user).member?).to be_truthy
      end

      it 'decorates the channel as #channel' do
        channel = FactoryGirl.create(:channel)
        use_valid_token
        post :join, id: channel.to_param
        expect(controller.channel).to be_decorated
        expect(controller.channel).to eq(channel)
      end
    end
  end
end

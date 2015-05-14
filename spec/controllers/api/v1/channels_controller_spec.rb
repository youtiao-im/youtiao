require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  describe 'GET #show' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :show, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when channel does not exist' do
        it 'responds with :not_found' do
          use_valid_access_token
          get :show, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when channel exists' do
        context 'for a channel not affiliated with user' do
          it 'responds with :forbidden' do
            channel = FactoryGirl.create(:channel)
            use_valid_access_token
            get :show, id: channel.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'for a channel affiliated with user' do
          it 'responds with :ok' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            use_valid_access_token_for user
            get :show, id: channel.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates the channel as #channel' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            use_valid_access_token_for user
            get :show, id: channel.to_param
            expect(controller.channel).to be_decorated
            expect(controller.channel).to eq(channel)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'with invalid parameters' do
        let(:invalid_params) { FactoryGirl.build(:invalid_channel).attributes }

        it 'responds with :bad_request' do
          use_valid_access_token
          post :create, invalid_params
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with valid parameters' do
        let(:valid_params) { FactoryGirl.build(:channel).attributes }

        it 'responds with :ok' do
          use_valid_access_token
          post :create, valid_params
          expect(response).to have_http_status(:ok)
        end

        it 'creates a new channel' do
          use_valid_access_token
          expect do
            post :create, valid_params
          end.to change(Channel, :count).by(1)
        end

        # TODO: add me
        # it 'adds user to the new channel as an owner' do
        #   user = FactoryGirl.create(:user)
        #   use_valid_access_token_for user
        #   post :create, valid_params
        #   expect(Channel.last.channel_user(user).owner?).to be_truthy
        # end

        it 'decorates the new channel as #channel' do
          use_valid_access_token
          post :create, valid_params
          expect(controller.channel).to be_decorated
          expect(controller.channel).to eq(Channel.last)
        end
      end
    end
  end
end

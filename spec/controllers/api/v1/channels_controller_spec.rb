require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

  describe 'GET #show' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :show, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a channel not exists' do
        it 'responds with :not_found' do
          get :show, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a channel exists' do
        context 'when channel is not affiliated with user' do
          it 'responds with :forbidden' do
            get :show, id: channel.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when channel is affiliated with user' do
          before do
            create(:membership, channel: channel, user: user)
          end

          it 'responds with :ok' do
            get :show, id: channel.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates the channel as #channel' do
            get :show, id: channel.to_param
            expect(controller.channel).to be_decorated
            expect(controller.channel).to eq(channel)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'with invalid attributes' do
        it 'responds with :bad_request' do
          post :create, attributes_for(:invalid_channel)
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with valid attributes' do
        it 'responds with :ok' do
          post :create, attributes_for(:channel)
          expect(response).to have_http_status(:ok)
        end

        it 'creates a new channel' do
          expect do
            post :create, attributes_for(:channel)
          end.to change(Channel, :count).by(1)
        end

        it 'adds user to the new channel as an owner'

        it 'decorates the new channel as #channel' do
          post :create, attributes_for(:channel)
          expect(controller.channel).to be_decorated
          expect(controller.channel).to eq(Channel.last)
        end
      end
    end
  end
end

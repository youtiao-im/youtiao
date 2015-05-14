require 'rails_helper'

RSpec.describe Api::V1::AuthenticatedUsers::MembershipsController,\
               type: :controller do
  describe 'GET #index' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      it 'responds with :ok' do
        use_valid_access_token
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'decorates memberships of user as #memberships' do
        use_valid_access_token
        get :index
        expect(controller.memberships).to be_decorated
      end
    end
  end

  describe 'GET #show' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :show, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'for a channel not affiliated with user' do
        it 'responds with :not_found' do
          channel = FactoryGirl.create(:channel)
          use_valid_access_token
          get :show, channel_id: channel.to_param
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a channel affiliated with user' do
        it 'responds with :ok' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          FactoryGirl.create(:membership, channel: channel, user: user)
          use_valid_access_token_for user
          get :show, channel_id: channel.to_param
          expect(response).to have_http_status(:ok)
        end

        it 'decorates membership as #membership' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          membership = FactoryGirl.create(
            :membership, channel: channel, user: user)
          use_valid_access_token_for user
          get :show, channel_id: channel.to_param
          expect(controller.membership).to be_decorated
          expect(controller.membership).to eq(membership)
        end
      end
    end
  end

  describe 'PUT #create' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        put :create, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'for a channel affiliated with user' do
        it 'responds with :conflict' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:membership, user: user).channel
          use_valid_access_token_for user
          put :create, channel_id: channel.to_param
          expect(response).to have_http_status(:conflict)
        end
      end

      context 'for a channel not affiliated with user' do
        it 'responds with :ok' do
          channel = FactoryGirl.create(:channel)
          use_valid_access_token
          put :create, channel_id: channel.to_param
          expect(response).to have_http_status(:ok)
        end

        it 'creates a new membership' do
          channel = FactoryGirl.create(:channel)
          use_valid_access_token
          expect do
            put :create, channel_id: channel.to_param
          end.to change(Membership, :count).by(1)
        end

        it 'decorates the new membership as #membership' do
          channel = FactoryGirl.create(:channel)
          use_valid_access_token
          put :create, channel_id: channel.to_param
          expect(controller.membership).to be_decorated
          expect(controller.membership).to eq(Membership.last)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::Channels::MembershipsController, type: :controller do
  describe 'GET #index' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :index, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'for a channel not affiliated with user' do
        it 'responds with :forbidden' do
          channel = FactoryGirl.create(:channel)
          use_valid_access_token
          get :index, channel_id: channel.to_param
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'for a channel affiliated with user' do
        it 'responds with :ok' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          FactoryGirl.create(:membership, channel: channel, user: user)
          use_valid_access_token_for user
          get :index, channel_id: channel.to_param
          expect(response).to have_http_status(:ok)
        end

        it 'decorates memberships of channel as #memberships' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          membership = FactoryGirl.create(
            :membership, channel: channel, user: user)
          use_valid_access_token_for user
          get :index, channel_id: channel.to_param
          expect(controller.memberships).to be_decorated
          expect(controller.memberships).to match_array([membership])
        end
      end
    end
  end

  describe 'GET #show' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :show, channel_id: 0, user_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when channel is not affiliated with user' do
        it 'responds with :forbidden' do
          channel = FactoryGirl.create(:channel)
          use_valid_access_token
          get :show, channel_id: channel.to_param, user_id: 0
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when channel is affiliated with user' do
        context 'for a user not affiliated with channel' do
          it 'responds with :not_found' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            another_user = FactoryGirl.create(:user)
            use_valid_access_token_for user
            get :show, channel_id: channel.to_param,\
                       user_id: another_user.to_param
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'for a user affiliated with channel' do
          it 'responds with :ok' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            another_user = FactoryGirl.create(:user)
            FactoryGirl.create(:membership, channel: channel, user: another_user)
            use_valid_access_token_for user
            get :show, channel_id: channel.to_param, user_id: another_user.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates membership as #membership' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            another_user = FactoryGirl.create(:user)
            membership = FactoryGirl.create(
              :membership, channel: channel, user: another_user)
            use_valid_access_token_for user
            get :show, channel_id: channel.to_param, user_id: another_user.to_param
            expect(controller.membership).to be_decorated
            expect(controller.membership).to eq(membership)
          end
        end
      end
    end
  end
end

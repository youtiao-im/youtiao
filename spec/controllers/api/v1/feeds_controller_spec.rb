require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  describe 'GET #index' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :index, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when channel does not exist' do
        it 'responds with :not_found' do
          use_valid_access_token
          get :index, channel_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when channel exists' do
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

          it 'decorates all feeds of the channel as #feeds' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            use_valid_access_token_for user
            get :index, channel_id: channel.to_param
            expect(controller.feeds).to be_decorated
            expect(controller.feeds).to match_array([feed])
          end

          it 'sets pagination headers' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            use_valid_access_token_for user
            get :index, channel_id: channel.to_param
            expect(response.headers['Total']).to eq('0')
            expect(response.headers['Per-Page']).to eq('25')
          end
        end
      end
    end
  end

  describe 'GET #show' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :show, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when feed does not exist' do
        it 'responds with :not_found' do
          use_valid_access_token
          get :show, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when feed exists' do
        context 'when feed#channel is not affiliated with user' do
          it 'responds with :forbidden' do
            feed = FactoryGirl.create(:feed)
            use_valid_access_token
            get :show, id: feed.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed#channel is affiliated with user' do
          it 'responds with :ok' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            use_valid_access_token_for user
            get :show, id: feed.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates the feed as #feed' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            use_valid_access_token_for user
            get :show, id: feed.to_param
            expect(controller.feed).to be_decorated
            expect(controller.feed).to eq(feed)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        post :create, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when channel does not exist' do
        it 'responds with :not_found' do
          use_valid_access_token
          post :create, channel_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when channel exists' do
        context 'when channel is not affiliated with user' do
          it 'responds with :forbidden' do
            channel = FactoryGirl.create(:channel)
            use_valid_access_token
            post :create, channel_id: channel.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when user is not an admin of channel' do
          it 'responds with :forbidden' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            use_valid_access_token_for user
            post :create, channel_id: channel.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when user is an admin of channel' do
          context 'with invalid parameters' do
            let(:invalid_params) { FactoryGirl.build(:invalid_feed).attributes }

            it 'responds with :bad_request' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(
                :admin_membership, channel: channel, user: user)
              use_valid_access_token_for user
              post :create, invalid_params.merge(channel_id: channel.to_param)
              expect(response).to have_http_status(:bad_request)
            end
          end

          context 'with valid parameters' do
            let(:valid_params) { FactoryGirl.build(:feed).attributes }

            it 'responds with :ok' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(
                :admin_membership, channel: channel, user: user)
              use_valid_access_token_for user
              post :create, valid_params.merge(channel_id: channel.to_param)
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new feed' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(
                :admin_membership, channel: channel, user: user)
              use_valid_access_token_for user
              expect do
                post :create, valid_params.merge(channel_id: channel.to_param)
              end.to change(Feed, :count).by(1)
            end

            it 'decorates the new feed as #feed' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(
                :admin_membership, channel: channel, user: user)
              use_valid_access_token_for user
              post :create, valid_params.merge(channel_id: channel.to_param)
              expect(controller.feed).to be_decorated
              expect(controller.feed).to eq(Feed.last)
            end
          end
        end
      end
    end
  end
end

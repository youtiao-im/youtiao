require 'rails_helper'

RSpec.describe Api::V1::Feeds::MarksController, type: :controller do
  describe 'GET #index' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :index, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when feed#channel is not affiliated with user' do
        it 'responds with :forbidden' do
          feed = FactoryGirl.create(:feed)
          use_valid_access_token
          get :index, feed_id: feed.to_param
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when user is not an admin of feed#channel' do
        it 'responds with :forbidden' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          FactoryGirl.create(:membership, channel: channel, user: user)
          feed = FactoryGirl.create(:feed, channel: channel)
          use_valid_access_token_for user
          get :index, feed_id: feed.to_param
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when user is an admin of feed#channel' do
        it 'responds with :ok' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          FactoryGirl.create(:admin_membership, channel: channel, user: user)
          feed = FactoryGirl.create(:feed, channel: channel)
          use_valid_access_token_for user
          get :index, feed_id: feed.to_param
          expect(response).to have_http_status(:ok)
        end

        it 'decorates marks of feed as #marks' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          FactoryGirl.create(:admin_membership, channel: channel, user: user)
          feed = FactoryGirl.create(:feed, channel: channel)
          mark = FactoryGirl.create(:mark, feed: feed)
          use_valid_access_token_for user
          get :index, feed_id: feed.to_param
          expect(controller.marks).to be_decorated
          expect(controller.marks).to match_array([mark])
        end
      end
    end
  end

  describe 'GET #show' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :show, feed_id: 0, user_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when feed#channel is not affiliated with user' do
        it 'responds with :forbidden' do
          feed = FactoryGirl.create(:feed)
          use_valid_access_token
          get :show, feed_id: feed.to_param, user_id: 0
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when user is not an admin of feed#channel' do
        it 'responds with :forbidden' do
          user = FactoryGirl.create(:user)
          channel = FactoryGirl.create(:channel)
          FactoryGirl.create(:membership, channel: channel, user: user)
          feed = FactoryGirl.create(:feed, channel: channel)
          use_valid_access_token_for user
          get :show, feed_id: feed.to_param, user_id: 0
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when user is an admin of feed#channel' do
        context 'for a user not marked feed' do
          it 'responds with :not_found' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:admin_membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            another_user = FactoryGirl.create(:user)
            use_valid_access_token_for user
            get :show, feed_id: feed.to_param, user_id: another_user.to_param
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'for a user marked feed' do
          it 'responds with :ok' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:admin_membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            another_user = FactoryGirl.create(:user)
            FactoryGirl.create(:mark, feed: feed, user: another_user)
            use_valid_access_token_for user
            get :show, feed_id: feed.to_param, user_id: another_user.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates mark as #mark' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:admin_membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            another_user = FactoryGirl.create(:user)
            mark = FactoryGirl.create(:mark, feed: feed, user: another_user)
            use_valid_access_token_for user
            get :show, feed_id: feed.to_param, user_id: another_user.to_param
            expect(controller.mark).to be_decorated
            expect(controller.mark).to eq(mark)
          end
        end
      end
    end
  end
end

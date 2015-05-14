require 'rails_helper'

RSpec.describe Api::V1::AuthenticatedUsers::MarksController,\
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

      it 'decorates marks of user as #marks' do
        use_valid_access_token
        get :index
        expect(controller.marks).to be_decorated
        # TODO: check value
        # expect(controller.marks).to match_array([])
      end
    end
  end

  describe 'GET #show' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        get :show, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'for a feed not marked by user' do
        it 'responds with :not_found' do
          feed = FactoryGirl.create(:feed)
          use_valid_access_token
          get :show, feed_id: feed.to_param
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed marked by user' do
        it 'responds with :ok' do
          user = FactoryGirl.create(:user)
          feed = FactoryGirl.create(:feed)
          FactoryGirl.create(:mark, feed: feed, user: user)
          use_valid_access_token_for user
          get :show, feed_id: feed.to_param
          expect(response).to have_http_status(:ok)
        end

        it 'decorates mark as #mark' do
          user = FactoryGirl.create(:user)
          feed = FactoryGirl.create(:feed)
          mark = FactoryGirl.create(:mark, feed: feed, user: user)
          use_valid_access_token_for user
          get :show, feed_id: feed.to_param
          expect(controller.mark).to be_decorated
          expect(controller.mark).to eq(mark)
        end
      end
    end
  end

  describe 'PUT #create' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        put :create, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when feed#channel is not affiliated with user' do
        it 'responds with :forbidden' do
          feed = FactoryGirl.create(:feed)
          use_valid_access_token
          put :create, feed_id: feed.to_param
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when feed#channel is affiliated with user' do
        context 'with invalid parameters' do
          let(:invalid_params) { FactoryGirl.build(:invalid_mark).attributes }

          it 'responds with :bad_request' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            use_valid_access_token_for user
            put :create, invalid_params.merge(feed_id: feed.to_param)
            expect(response).to have_http_status(:bad_request)
          end
        end

        context 'with valid parameters' do
          let(:valid_params) { FactoryGirl.build(:mark).attributes }

          context 'for a feed marked by user' do
            it 'responds with :conflict' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              FactoryGirl.create(:mark, feed: feed, user: user)
              use_valid_access_token_for user
              put :create, valid_params.merge(feed_id: feed.to_param)
              expect(response).to have_http_status(:conflict)
            end
          end

          context 'for a feed not marked by user' do
            it 'responds with :ok' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              use_valid_access_token_for user
              put :create, valid_params.merge(feed_id: feed.to_param)
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new mark' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              use_valid_access_token_for user
              expect do
                put :create, valid_params.merge(feed_id: feed.to_param)
              end.to change(Mark, :count).by(1)
            end

            it 'decorates the new mark as #mark' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              use_valid_access_token_for user
              put :create, valid_params.merge(feed_id: feed.to_param)
              expect(controller.mark).to be_decorated
              expect(controller.mark).to eq(Mark.last)
            end
          end
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'with invalid access token' do
      it 'responds with :unauthorized' do
        use_invalid_access_token
        patch :update, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid access token' do
      context 'when feed#channel is not affiliated with user' do
        it 'responds with :forbidden' do
          user = FactoryGirl.create(:user)
          feed = FactoryGirl.create(:feed)
          FactoryGirl.create(:mark, feed: feed, user: user)
          use_valid_access_token_for user
          patch :update, feed_id: feed.to_param
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when feed#channel is affiliated with user' do
        context 'for a feed not marked by user' do
          it 'responds with :not_found' do
            user = FactoryGirl.create(:user)
            channel = FactoryGirl.create(:channel)
            FactoryGirl.create(:membership, channel: channel, user: user)
            feed = FactoryGirl.create(:feed, channel: channel)
            use_valid_access_token_for user
            patch :update, feed_id: feed.to_param
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'for a feed marked by user' do
          context 'with invalid parameters' do
            let(:invalid_params) { FactoryGirl.build(:invalid_mark).attributes }

            it 'responds with :bad_request' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              FactoryGirl.create(:mark, feed: feed, user: user)
              use_valid_access_token_for user
              patch :update, invalid_params.merge(feed_id: feed.to_param)
              expect(response).to have_http_status(:bad_request)
            end
          end

          context 'with valid paramters' do
            let(:valid_params) { FactoryGirl.build(:mark).attributes }

            it 'responds with :ok' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              FactoryGirl.create(:mark, feed: feed, user: user)
              use_valid_access_token_for user
              patch :update, valid_params.merge(feed_id: feed.to_param)
              expect(response).to have_http_status(:ok)
            end

            it 'updates the existing mark' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              mark = FactoryGirl.create(:mark, feed: feed, user: user)
              use_valid_access_token_for user
              patch :update, valid_params.merge(feed_id: feed.to_param)
              expect(mark.reload.symbol).to eq(valid_params['symbol'])
            end

            it 'decorates the updated mark as #mark' do
              user = FactoryGirl.create(:user)
              channel = FactoryGirl.create(:channel)
              FactoryGirl.create(:membership, channel: channel, user: user)
              feed = FactoryGirl.create(:feed, channel: channel)
              mark = FactoryGirl.create(:mark, feed: feed, user: user)
              use_valid_access_token_for user
              patch :update, valid_params.merge(feed_id: feed.to_param)
              expect(controller.mark).to be_decorated
              expect(controller.mark).to eq(mark)
            end
          end
        end
      end
    end
  end
end

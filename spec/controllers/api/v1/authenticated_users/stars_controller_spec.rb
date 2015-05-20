require 'rails_helper'

RSpec.describe Api::V1::AuthenticatedUsers::StarsController,
               type: :controller do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      it 'responds with :ok' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'decorates stars of user as #stars' do
        star = create(:star, user: user)
        get :index
        expect(controller.stars).to be_decorated
        expect(controller.stars).to match_array([star])
      end

      it 'sets pagination headers' do
        get :index
        expect(response.headers['X-Total']).to_not be_nil
        expect(response.headers['X-Per-Page']).to_not be_nil
      end
    end
  end

  describe 'GET #show' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :show, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a feed not exists' do
        it 'responds with :not_found' do
          get :show, feed_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed exists' do
        context 'when feed is not starred by user' do
          it 'responds with :not_found' do
            get :show, feed_id: feed.to_param
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'when feed is starred by user' do
          before do
            create(:star, feed: feed, user: user)
          end

          it 'responds with :ok' do
            get :show, feed_id: feed.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates star as #star' do
            get :show, feed_id: feed.to_param
            expect(controller.star).to be_decorated
            expect(controller.star).to eq(Star.pinpoint(feed.id, user.id))
          end
        end
      end
    end
  end

  describe 'PUT #create' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        put :create, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a feed not exists' do
        it 'responds with :not_found' do
          put :create, feed_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed exists' do
        context 'when feed belongs to a channel not affiliated with user' do
          it 'responds with :forbidden' do
            put :create, feed_id: feed.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed belongs to a channel affiliated with user' do
          before do
            create(:membership, channel: feed.channel, user: user)
          end

          context 'when feed is starred by user' do
            it 'responds with :conflict' do
              create(:star, feed: feed, user: user)
              put :create, feed_id: feed.to_param
              expect(response).to have_http_status(:conflict)
            end
          end

          context 'when feed is not starred by user' do
            it 'responds with :ok' do
              put :create, feed_id: feed.to_param
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new star' do
              expect do
                put :create, feed_id: feed.to_param
              end.to change(Star, :count).by(1)
            end

            it 'decorates the created star as #star' do
              put :create, feed_id: feed.to_param
              expect(controller.star).to be_decorated
              expect(controller.star).to eq(Star.last)
            end
          end
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::Feeds::StarsController, type: :controller do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a feed not exists' do
        it 'responds with :not_found' do
          get :index, feed_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed exists' do
        context 'when feed belongs to a channel not affiliated with user' do
          it 'responds with :forbidden' do
            get :index, feed_id: feed.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed belongs to a channel affiliated with user' do
          context 'when user is not an admin of channel' do
            it 'responds with :forbidden' do
              create(:membership, channel: feed.channel, user: user)
              get :index, feed_id: feed.to_param
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when user is an admin of channel' do
            before do
              create(:admin_membership, channel: feed.channel, user: user)
            end

            it 'responds with :ok' do
              get :index, feed_id: feed.to_param
              expect(response).to have_http_status(:ok)
            end

            it 'decorates stars of feed as #stars' do
              star = create(:star, feed: feed)
              get :index, feed_id: feed.to_param
              expect(controller.stars).to be_decorated
              expect(controller.stars).to match_array([star])
            end

            it 'sets pagination headers' do
              get :index, feed_id: feed.to_param
              expect(response.headers['X-Total']).to_not be_nil
              expect(response.headers['X-Per-Page']).to_not be_nil
            end
          end
        end
      end
    end
  end

  describe 'GET #show' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :show, feed_id: 0, user_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a feed not exists' do
        it 'responds with :not_found' do
          get :show, feed_id: 0, user_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed exists' do
        context 'when feed belongs to a channel not affiliated with user' do
          it 'responds with :forbidden' do
            get :show, feed_id: feed.to_param, user_id: 0
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed belongs to a channel affiliated with user' do
          context 'when user is not an admin of channel' do
            it 'responds with :forbidden' do
              create(:membership, channel: feed.channel, user: user)
              get :show, feed_id: feed.to_param, user_id: 0
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when user is an admin of channel' do
            before do
              create(:admin_membership, channel: feed.channel, user: user)
            end

            context 'for a user not starred feed' do
              it 'responds with :not_found' do
                another_user = create(:user)
                get :show, feed_id: feed.to_param, user_id: another_user.to_param
                expect(response).to have_http_status(:not_found)
              end
            end

            context 'for a user starred feed' do
              it 'responds with :ok' do
                star = create(:star, feed: feed)
                get :show, feed_id: feed.to_param, user_id: star.user.to_param
                expect(response).to have_http_status(:ok)
              end

              it 'decorates star as #star' do
                star = create(:star, feed: feed)
                get :show, feed_id: feed.to_param, user_id: star.user.to_param
                expect(controller.star).to be_decorated
                expect(controller.star).to eq(star)
              end
            end
          end
        end
      end
    end
  end
end

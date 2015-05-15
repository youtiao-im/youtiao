require 'rails_helper'

RSpec.describe Api::V1::Feeds::MarksController, type: :controller do
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

            it 'decorates marks of feed as #marks' do
              mark = create(:mark, feed: feed)
              get :index, feed_id: feed.to_param
              expect(controller.marks).to be_decorated
              expect(controller.marks).to match_array([mark])
            end

            it 'sets pagination headers' do
              get :index, feed_id: feed.to_param
              expect(response.headers['Total']).to_not be_nil
              expect(response.headers['Per-Page']).to_not be_nil
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

            context 'for a user not marked feed' do
              it 'responds with :not_found' do
                another_user = create(:user)
                get :show, feed_id: feed.to_param, user_id: another_user.to_param
                expect(response).to have_http_status(:not_found)
              end
            end

            context 'for a user marked feed' do
              it 'responds with :ok' do
                mark = create(:mark, feed: feed)
                get :show, feed_id: feed.to_param, user_id: mark.user.to_param
                expect(response).to have_http_status(:ok)
              end

              it 'decorates mark as #mark' do
                mark = create(:mark, feed: feed)
                get :show, feed_id: feed.to_param, user_id: mark.user.to_param
                expect(controller.mark).to be_decorated
                expect(controller.mark).to eq(mark)
              end
            end
          end
        end
      end
    end
  end
end

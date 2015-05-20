require 'rails_helper'

RSpec.describe Api::V1::AuthenticatedUsers::MarksController,
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

      it 'decorates marks of user as #marks' do
        mark = create(:mark, user: user)
        get :index
        expect(controller.marks).to be_decorated
        expect(controller.marks).to match_array([mark])
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
        context 'when feed is not marked by user' do
          it 'responds with :not_found' do
            get :show, feed_id: feed.to_param
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'when feed is marked by user' do
          before do
            create(:mark, feed: feed, user: user)
          end

          it 'responds with :ok' do
            get :show, feed_id: feed.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates mark as #mark' do
            get :show, feed_id: feed.to_param
            expect(controller.mark).to be_decorated
            expect(controller.mark).to eq(Mark.pinpoint(feed.id, user.id))
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

          context 'with invalid attributes' do
            it 'responds with :bad_request' do
              put :create, { feed_id: feed.to_param }.merge(
                attributes_for(:invalid_mark))
              expect(response).to have_http_status(:bad_request)
            end
          end

          context 'with valid attributes' do
            context 'when feed is marked by user' do
              it 'responds with :conflict' do
                create(:mark, feed: feed, user: user)
                put :create, { feed_id: feed.to_param }.merge(
                  attributes_for(:mark))
                expect(response).to have_http_status(:conflict)
              end
            end

            context 'when feed is not marked by user' do
              it 'responds with :ok' do
                put :create, { feed_id: feed.to_param }.merge(
                  attributes_for(:mark))
                expect(response).to have_http_status(:ok)
              end

              it 'creates a new mark' do
                expect do
                  put :create, { feed_id: feed.to_param }.merge(
                    attributes_for(:mark))
                end.to change(Mark, :count).by(1)
              end

              it 'decorates the created mark as #mark' do
                put :create, { feed_id: feed.to_param }.merge(
                  attributes_for(:mark))
                expect(controller.mark).to be_decorated
                expect(controller.mark).to eq(Mark.last)
              end
            end
          end
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        patch :update, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a feed not exists' do
        it 'responds with :not_found' do
          patch :update, feed_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed exists' do
        context 'when feed belongs to a channel not affiliated with user' do
          it 'responds with :forbidden' do
            patch :update, feed_id: feed.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed belongs to a channel affiliated with user' do
          before do
            create(:membership, channel: feed.channel, user: user)
          end

          context 'when feed is not marked by user' do
            it 'responds with :not_found' do
              patch :update, feed_id: feed.to_param
              expect(response).to have_http_status(:not_found)
            end
          end

          context 'when feed is marked by user' do
            before do
              create(:mark, feed: feed, user: user)
            end

            context 'with invalid attributes' do
              it 'responds with :bad_request' do
                patch :update, { feed_id: feed.to_param }.merge(
                  attributes_for(:invalid_mark))
                expect(response).to have_http_status(:bad_request)
              end
            end

            context 'with valid attributes' do
              it 'responds with :ok' do
                patch :update, { feed_id: feed.to_param }.merge(
                  attributes_for(:mark))
                expect(response).to have_http_status(:ok)
              end

              it 'updates mark'

              it 'decorates the updated mark as #mark' do
                patch :update, { feed_id: feed.to_param }.merge(
                  attributes_for(:mark))
                expect(controller.mark).to be_decorated
                expect(controller.mark).to eq(Mark.pinpoint(feed.id, user.id))
              end
            end
          end
        end
      end
    end
  end
end

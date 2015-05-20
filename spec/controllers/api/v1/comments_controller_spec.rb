require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:comment) { create(:comment) }

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
        context 'when feed.channel is not affiliated with user' do
          it 'responds with :forbidden' do
            get :index, feed_id: feed.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed.channel is affiliated with user' do
          before do
            create(:membership, channel: feed.channel, user: user)
          end

          it 'responds with :ok' do
            get :index, feed_id: feed.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates comments of feed as #comments' do
            comment = create(:comment, feed: feed)
            get :index, feed_id: feed.to_param
            expect(controller.comments).to be_decorated
            expect(controller.comments).to match_array([comment])
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

      context 'for a comment not exists' do
        it 'responds with :not_found' do
          get :show, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a comment exists' do
        context 'when comment belongs to a feed whose channel is not '\
          'affiliated with user' do
          it 'responds with :forbidden' do
            get :show, id: comment.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when comment belongs to a feed whose channel is affiliated '\
          'with user' do
          before do
            create(:membership, channel: comment.feed.channel, user: user)
          end

          it 'responds with :ok' do
            get :show, id: comment.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates comment as #comment' do
            get :show, id: comment.to_param
            expect(controller.comment).to be_decorated
            expect(controller.comment).to eq(comment)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        post :create, feed_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a feed not exists' do
        it 'responds with :not_found' do
          post :create, feed_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed exists' do
        context 'when feed.channel is not affiliated with user' do
          it 'responds with :forbidden' do
            post :create, feed_id: feed.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed.channel is affiliated with user' do
          before do
            create(:membership, channel: feed.channel, user: user)
          end

          context 'with invalid attributes' do
            it 'responds with :bad_request' do
              post :create, { feed_id: feed.to_param }.merge(
                attributes_for(:invalid_comment))
              expect(response).to have_http_status(:bad_request)
            end
          end

          context 'with valid attributes' do
            it 'responds with :ok' do
              post :create, { feed_id: feed.to_param }.merge(
                attributes_for(:comment))
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new comment' do
              expect do
                post :create, { feed_id: feed.to_param }.merge(
                  attributes_for(:comment))
              end.to change(Comment, :count).by(1)
            end

            it 'decorates the new feed as #feed' do
              post :create, { feed_id: feed.to_param }.merge(
                attributes_for(:comment))
              expect(controller.comment).to be_decorated
              expect(controller.comment).to eq(Comment.last)
            end
          end
        end
      end
    end
  end
end

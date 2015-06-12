require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:bulletin) { create(:bulletin) }
  let(:comment) { create(:comment) }

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index, bulletin_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a bulletin not exists' do
        it 'responds with :not_found' do
          get :index, bulletin_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a bulletin exists' do
        context 'when bulletin.group is not affiliated with user' do
          it 'responds with :forbidden' do
            get :index, bulletin_id: bulletin.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when bulletin.group is affiliated with user' do
          before do
            create(:membership, group: bulletin.group, user: user)
          end

          it 'responds with :ok' do
            get :index, bulletin_id: bulletin.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates comments of bulletin as #comments' do
            comment = create(:comment, bulletin: bulletin)
            get :index, bulletin_id: bulletin.to_param
            expect(controller.comments).to be_decorated
            expect(controller.comments).to match_array([comment])
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
        context 'when comment.bulletin.group is not affiliated with user' do
          it 'responds with :forbidden' do
            get :show, id: comment.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when comment.bulletin.group is affiliated with user' do
          before do
            create(:membership, group: comment.bulletin.group, user: user)
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
        post :create, bulletin_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a bulletin not exists' do
        it 'responds with :not_found' do
          post :create, bulletin_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a bulletin exists' do
        context 'when bulletin.group is not affiliated with user' do
          it 'responds with :forbidden' do
            post :create, bulletin_id: bulletin.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when bulletin.group is affiliated with user' do
          before do
            create(:membership, group: bulletin.group, user: user)
          end

          context 'with invalid attributes' do
            it 'responds with :bad_request' do
              post :create, { bulletin_id: bulletin.to_param }.merge(
                attributes_for(:invalid_comment))
              expect(response).to have_http_status(:bad_request)
            end
          end

          context 'with valid attributes' do
            it 'responds with :ok' do
              post :create, { bulletin_id: bulletin.to_param }.merge(
                attributes_for(:comment))
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new comment' do
              expect do
                post :create, { bulletin_id: bulletin.to_param }.merge(
                  attributes_for(:comment))
              end.to change(Comment, :count).by(1)
            end

            it 'decorates the created comment as #comment' do
              post :create, { bulletin_id: bulletin.to_param }.merge(
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

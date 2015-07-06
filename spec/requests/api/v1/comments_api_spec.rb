require 'rails_helper'

RSpec.describe V1::CommentsAPI, type: :request do
  let(:user) { create(:user) }
  let(:bulletin) { create(:bulletin) }
  let(:comment) { create(:comment) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET comments.list' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        get '/api/v1/comments.list'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing bulletin' do
        it 'responds with :not_found' do
          get '/api/v1/comments.list',
              bulletin_id: 0,
              access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing bulletin' do
        context 'when current user is NOT a member of bulletin.group' do
          it 'responds with :forbidden' do
            get '/api/v1/comments.list',
                bulletin_id: bulletin.to_param,
                access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is a member of bulletin.group' do
          before do
            create(:membership, group: bulletin.group, user: user)
          end

          it 'responds with :ok' do
            get '/api/v1/comments.list',
                bulletin_id: bulletin.to_param,
                access_token: access_token
            expect(response).to have_http_status(:ok)
          end

          it 'returns comments of the bulletin' do
            comment = create(:comment, bulletin: bulletin)
            get '/api/v1/comments.list',
                bulletin_id: bulletin.to_param,
                access_token: access_token
            expect(response.body).to match_json_expression(
              [
                {
                  type: 'Comment',
                  id: comment.to_param
                }.ignore_extra_keys!
              ])
          end
        end
      end
    end
  end

  describe 'POST comments.create' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/comments.create'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing bulletin' do
        it 'responds with :not_found' do
          post '/api/v1/comments.create',
               bulletin_id: 0,
               access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing bulletin' do
        context 'when current user is NOT a member of bulletin.group' do
          it 'responds with :forbidden' do
            post '/api/v1/comments.create',
                 bulletin_id: bulletin.to_param,
                 access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is a member of bulletin.group' do
          before do
            create(:membership, group: bulletin.group, user: user)
          end

          context 'with INVALID attributes' do
            it 'responds with :unprocessable_entity' do
              post '/api/v1/comments.create',
                   attributes_for(:invalid_comment).merge(
                     bulletin_id: bulletin.to_param,
                     access_token: access_token)
              expect(response).to have_http_status(:unprocessable_entity)
            end
          end

          context 'with valid attributes' do
            it 'responds with :ok' do
              post '/api/v1/comments.create',
                   attributes_for(:comment).merge(
                     bulletin_id: bulletin.to_param,
                     access_token: access_token)
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new comment' do
              expect do
                post '/api/v1/comments.create',
                     attributes_for(:comment).merge(
                       bulletin_id: bulletin.to_param,
                       access_token: access_token)
              end.to change(Comment, :count).by(1)
            end

            it 'returns the created comment' do
              post '/api/v1/comments.create',
                   attributes_for(:comment).merge(
                     bulletin_id: bulletin.to_param,
                     access_token: access_token)
              expect(response.body).to match_json_expression(
                {
                  type: 'Comment',
                  id: Comment.last.to_param
                }.ignore_extra_keys!)
            end
          end
        end
      end
    end
  end
end

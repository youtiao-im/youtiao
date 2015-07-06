require 'rails_helper'

RSpec.describe V1::UsersAPI, type: :request do
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'POST users.register' do
    context 'with INVALID attributes' do
      it 'responds with :unprocessable_entity' do
        post '/api/v1/users.register',
             attributes_for(:invalid_user)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with valid attributes' do
      it 'responds with :ok' do
        post '/api/v1/users.register',
             attributes_for(:user)
      end

      it 'createds a new user' do
        expect do
          post '/api/v1/users.register',
               attributes_for(:user)
        end.to change(User, :count).by(1)
      end

      it 'returns the created user' do
        post '/api/v1/users.register',
             attributes_for(:user)
        expect(response.body).to match_json_expression(
          {
            type: 'User',
            id: User.last.to_param
          }.ignore_extra_keys!)
      end
    end
  end

  describe 'GET user.info' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        get '/api/v1/user.info'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      it 'responds with :ok' do
        get '/api/v1/user.info',
            access_token: access_token
        expect(response).to have_http_status(:ok)
      end

      it 'returns current user' do
        get '/api/v1/user.info',
            access_token: access_token
        expect(response.body).to match_json_expression(
          {
            type: 'User',
            id: user.to_param
          }.ignore_extra_keys!)
      end
    end
  end

  describe 'POST user.update' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/user.update'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'with INVALID attributes' do
        it 'responds with :unprocessable_entity' do
          post '/api/v1/user.update',
               attributes_for(:invalid_user).merge(
                 access_token: access_token)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with valid attributes' do
        it 'responds with :ok' do
          post '/api/v1/user.update',
               attributes_for(:user).merge(
                 access_token: access_token)
          expect(response).to have_http_status(:ok)
        end

        it 'returns current user' do
          post '/api/v1/user.update',
               attributes_for(:user).merge(
                 access_token: access_token)
          expect(response.body).to match_json_expression(
            {
              type: 'User',
              id: user.to_param
            }.ignore_extra_keys!)
        end
      end
    end
  end

  describe 'POST user.change_password' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/user.change_password'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      let(:new_password) { user.password.reverse }

      context 'with INCORRECT password' do
        it 'responds with :forbidden' do
          post '/api/v1/user.change_password',
               { password: user.password + '_',
                 new_password: new_password }.merge(
                   access_token: access_token)
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'with correct password' do
        it 'responds with :ok' do
          post '/api/v1/user.change_password',
               { password: user.password,
                 new_password: new_password }.merge(
                   access_token: access_token)
          expect(response).to have_http_status(:ok)
        end

        it 'updates password for current user' do
          post '/api/v1/user.change_password',
               { password: user.password,
                 new_password: new_password }.merge(
                   access_token: access_token)
          expect(User.find(user.id).updated_at).to_not eq(user.updated_at)
        end

        it 'revokes all access tokens of current user' do
          post '/api/v1/user.change_password',
               { password: user.password,
                 new_password: new_password }.merge(
                   access_token: access_token)
          expect(user.access_tokens).to be_empty
        end

        it 'returns current user' do
          post '/api/v1/user.change_password',
               { password: user.password,
                 new_password: new_password }.merge(
                   access_token: access_token)
          expect(response.body).to match_json_expression(
            {
              type: 'User',
              id: user.to_param
            }.ignore_extra_keys!)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe V1::UsersAPI, type: :request do
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET users.current' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        get '/api/v1/users.current'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      it 'responds with :ok' do
        get '/api/v1/users.current',
            access_token: access_token
        expect(response).to have_http_status(:ok)
      end

      it 'returns current user' do
        get '/api/v1/users.current',
            access_token: access_token
        expect(response.body).to match_json_expression(
          {
            type: 'User',
            id: user.to_param
          }.ignore_extra_keys!)
      end
    end
  end
end

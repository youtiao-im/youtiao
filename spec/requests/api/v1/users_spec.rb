require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      type: 'User',
      id: String,
      email: String,
      created_at: String,
      updated_at: String
    }
  end

  describe 'GET /api/v1/user' do
    it 'returns current authenticated user' do
      get '/api/v1/user',
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

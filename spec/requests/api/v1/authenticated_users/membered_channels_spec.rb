require 'rails_helper'

RSpec.describe 'Api::V1::AuthenticatedUsers::MemberedChannels', type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      id: String,
      name: String,
      memberships_count: Fixnum,
      created_at: Fixnum,
      updated_at: Fixnum,
      created_by: {
        id: String,
        email: String,
        created_at: Fixnum,
        updated_at: Fixnum
      },
      membership: {
        role: String,
        created_at: Fixnum,
        updated_at: Fixnum
      }
    }
  end

  describe 'GET /api/v1/user/membered_channels' do
    it 'returns channels membered by current user' do
      create(:membership, channel: channel, user: user)
      get '/api/v1/user/membered_channels', {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/user/membered_channels/:id' do
    it 'returns the requested membered channel' do
      create(:membership, channel: channel, user: user)
      get "/api/v1/user/membered_channels/#{channel.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'PUT /api/v1/user/membered_channels/:id' do
    it 'returns the created membered channel' do
      put "/api/v1/user/membered_channels/#{channel.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

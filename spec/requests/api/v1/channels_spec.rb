require 'rails_helper'

RSpec.describe 'Api::V1::Channels', type: :request do
  let(:user) { create(:user) }
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

  describe 'GET /api/v1/channels/:id' do
    it 'returns the requested channel' do
      channel = create(:channel)
      create(:membership, channel: channel, user: user)
      get "/api/v1/channels/#{channel.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'POST /api/v1/channels' do
    it 'returns the created channel' do
      post '/api/v1/channels', attributes_for(:channel),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

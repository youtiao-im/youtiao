require 'rails_helper'

RSpec.describe 'Api::V1::Channels', type: :request do
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET /api/v1/channels/:id' do
    it 'returns the requested channel' do
      channel = create(:channel)
      create(:membership, channel: channel, user: user)
      get "/api/v1/channels/#{channel.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        id: channel.to_param,
        name: channel.name,
        created_at: channel.created_at.to_i,
        updated_at: channel.updated_at.to_i,
        created_by: {
          id: channel.created_by.to_param,
          email: channel.created_by.email
        }
      )
    end
  end

  describe 'POST /api/v1/channels' do
    it 'returns the created channel' do
      post '/api/v1/channels', attributes_for(:channel),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        id: String,
        name: String,
        created_at: Fixnum,
        updated_at: Fixnum,
        created_by: {
          id: user.to_param,
          email: user.email
        }
      )
    end
  end
end

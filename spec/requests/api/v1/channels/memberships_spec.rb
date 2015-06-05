require 'rails_helper'

RSpec.describe 'Api::V1::Channels::Memberships', type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      role: String,
      created_at: Fixnum,
      updated_at: Fixnum,
      user: {
        id: String,
        email: String,
        created_at: Fixnum,
        updated_at: Fixnum
      }
    }
  end

  before do
    create(:membership, channel: channel, user: user)
  end

  describe 'GET /api/v1/channels/:channel_id/memberships' do
    it 'returns memberships of the requested channel' do
      get "/api/v1/channels/#{channel.to_param}/memberships", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/channels/:channel_id/memberships/users/:user_id' do
    it 'returns the requested membership' do
      membership = create(:membership, channel: channel)
      get "/api/v1/channels/#{channel.to_param}/memberships/users"\
          "/#{membership.user.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

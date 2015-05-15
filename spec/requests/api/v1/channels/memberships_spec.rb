require 'rails_helper'

RSpec.describe 'Api::V1::Channels::Memberships', type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  before do
    create(:membership, channel: channel, user: user)
  end

  describe 'GET /api/v1/channels/:channel_id/memberships' do
    it 'returns memberships of the requested channel' do
      get "/api/v1/channels/#{channel.to_param}/memberships", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
            role: String,
            created_at: Fixnum,
            updated_at: Fixnum,
            user: {
              id: user.to_param,
              email: user.email
            }
          }
        ]
      )
    end
  end

  describe 'GET /api/v1/channels/:channel_id/memberships/users/:user_id' do
    it 'returns the requested membership' do
      membership = create(:membership, channel: channel)
      get "/api/v1/channels/#{channel.to_param}/memberships/users"\
          "/#{membership.user.to_param}",
          {}, 'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        role: membership.role,
        created_at: membership.created_at.to_i,
        updated_at: membership.updated_at.to_i,
        user: {
          id: membership.user.to_param,
          email: membership.user.email
        }
      )
    end
  end
end

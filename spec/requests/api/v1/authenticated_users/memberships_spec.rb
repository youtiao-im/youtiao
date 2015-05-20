require 'rails_helper'

RSpec.describe 'Api::V1::AuthenticatedUsers::Memberships', type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET /api/v1/user/memberships' do
    it 'returns memberships of user' do
      membership = create(:membership, channel: channel, user: user)
      get '/api/v1/user/memberships', {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
            role: membership.role,
            created_at: membership.created_at.to_i,
            updated_at: membership.updated_at.to_i,
            channel: {
              id: channel.to_param,
              name: channel.name,
              memberships_count: Fixnum,
              created_at: channel.created_at.to_i,
              updated_at: channel.updated_at.to_i,
              created_by: {
                id: channel.created_by.to_param,
                email: channel.created_by.email
              }
            }
          }
        ]
      )
    end
  end

  describe 'GET /api/v1/user/memberships/channels/:channel_id' do
    it 'returns the requested membership' do
      membership = create(:membership, channel: channel, user: user)
      get "/api/v1/user/memberships/channels/#{channel.to_param}",
          {}, 'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        role: membership.role,
        created_at: membership.created_at.to_i,
        updated_at: membership.updated_at.to_i,
        channel: {
          id: channel.to_param,
          name: channel.name,
          memberships_count: Fixnum,
          created_at: channel.created_at.to_i,
          updated_at: channel.updated_at.to_i,
          created_by: {
            id: channel.created_by.to_param,
            email: channel.created_by.email
          }
        }
      )
    end
  end

  describe 'PUT /api/v1/user/memberships/channels/:channel_id' do
    it 'returns the created membership' do
      put "/api/v1/user/memberships/channels/#{channel.to_param}",
          {}, 'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        role: String,
        created_at: Fixnum,
        updated_at: Fixnum,
        channel: {
          id: channel.to_param,
          name: channel.name,
          memberships_count: Fixnum,
          created_at: channel.created_at.to_i,
          updated_at: channel.updated_at.to_i,
          created_by: {
            id: channel.created_by.to_param,
            email: channel.created_by.email
          }
        }
      )
    end
  end
end

require 'rails_helper'

RSpec.describe 'Api::V1::AuthenticatedUsers::Feeds', type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      id: String,
      text: String,
      checks_count: Fixnum,
      crosses_count: Fixnum,
      comments_count: Fixnum,
      created_at: Fixnum,
      updated_at: Fixnum,
      created_by: {
        id: String,
        email: String,
        created_at: Fixnum,
        updated_at: Fixnum
      },
      channel: {
        id: String,
        name: String,
        memberships_count: Fixnum,
        created_at: Fixnum,
        updated_at: Fixnum
      }
    }
  end

  before do
    create(:membership, channel: channel, user: user)
  end

  describe 'GET /api/v1/user/feeds' do
    it 'returns feeds to user' do
      create(:feed, channel: channel)
      get '/api/v1/user/feeds', {}, 'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end
end

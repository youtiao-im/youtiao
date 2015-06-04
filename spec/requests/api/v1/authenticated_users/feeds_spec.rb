require 'rails_helper'

RSpec.describe 'Api::V1::AuthenticatedUsers::Feeds', type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  before do
    create(:membership, channel: channel, user: user)
  end

  describe 'GET /api/v1/user/feeds' do
    it 'returns feeds to user' do
      create(:feed, channel: channel)
      get '/api/v1/user/feeds', {}, 'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
            id: String,
            text: String,
            checks_count: Fixnum,
            crosses_count: Fixnum,
            questions_count: Fixnum,
            comments_count: Fixnum,
            created_at: Fixnum,
            updated_at: Fixnum,
            channel: {
              id: String,
              name: String,
              memberships_count: Fixnum,
              created_at: Fixnum,
              updated_at: Fixnum,
              created_by: {
                id: String,
                email: String
              }
            },
            created_by: {
              id: String,
              email: String
            }
          }
        ]
      )
    end
  end
end

require 'rails_helper'

RSpec.describe 'Api::V1::Feeds::Marks', type: :request do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  before do
    create(:admin_membership, channel: feed.channel, user: user)
  end

  describe 'GET /api/v1/feeds/:feed_id/marks' do
    it 'returns marks of the requested feed' do
      mark = create(:mark, feed: feed)
      get "/api/v1/feeds/#{feed.to_param}/marks", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
            symbol: mark.symbol,
            created_at: mark.created_at.to_i,
            updated_at: mark.updated_at.to_i,
            user: {
              id: mark.user.to_param,
              email: mark.user.email
            }
          }
        ]
      )
    end
  end

  describe 'GET /api/v1/feeds/:feed_id/marks/users/:user_id' do
    it 'returns the requested mark' do
      mark = create(:mark, feed: feed)
      get "/api/v1/feeds/#{feed.to_param}/marks/users/#{mark.user.to_param}",
          {}, 'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        symbol: mark.symbol,
        created_at: mark.created_at.to_i,
        updated_at: mark.updated_at.to_i,
        user: {
          id: mark.user.to_param,
          email: mark.user.email
        }
      )
    end
  end
end

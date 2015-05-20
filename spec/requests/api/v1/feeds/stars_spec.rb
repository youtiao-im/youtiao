require 'rails_helper'

RSpec.describe 'Api::V1::Feeds::Stars', type: :request do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  before do
    create(:admin_membership, channel: feed.channel, user: user)
  end

  describe 'GET /api/v1/feeds/:feed_id/stars' do
    it 'returns stars of the requested feed' do
      star = create(:star, feed: feed)
      get "/api/v1/feeds/#{feed.to_param}/stars", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
            created_at: star.created_at.to_i,
            updated_at: star.updated_at.to_i,
            user: {
              id: star.user.to_param,
              email: star.user.email
            }
          }
        ]
      )
    end
  end

  describe 'GET /api/v1/feeds/:feed_id/stars/users/:user_id' do
    it 'returns the requested star' do
      star = create(:star, feed: feed)
      get "/api/v1/feeds/#{feed.to_param}/stars/users/#{star.user.to_param}",
          {}, 'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        created_at: star.created_at.to_i,
        updated_at: star.updated_at.to_i,
        user: {
          id: star.user.to_param,
          email: star.user.email
        }
      )
    end
  end
end

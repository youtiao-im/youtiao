require 'rails_helper'

RSpec.describe 'Api::V1::AuthenticatedUsers::Stars', type: :request do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET /api/v1/user/stars' do
    it 'returns stars of user' do
      star = create(:star, feed: feed, user: user)
      get '/api/v1/user/stars', {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
            created_at: star.created_at.to_i,
            updated_at: star.updated_at.to_i,
            feed: {
              id: feed.to_param,
              text: feed.text,
              checks_count: Fixnum,
              crosses_count: Fixnum,
              questions_count: Fixnum,
              comments_count: Fixnum,
              created_at: feed.created_at.to_i,
              updated_at: feed.updated_at.to_i,
              created_by: {
                id: feed.created_by.to_param,
                email: feed.created_by.email
              }
            }
          }
        ]
      )
    end
  end

  describe 'GET /api/v1/user/stars/feeds/:feed_id' do
    it 'returns the requested star' do
      star = create(:star, feed: feed, user: user)
      get "/api/v1/user/stars/feeds/#{feed.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        created_at: star.created_at.to_i,
        updated_at: star.updated_at.to_i,
        feed: {
          id: feed.to_param,
          text: feed.text,
          checks_count: Fixnum,
          crosses_count: Fixnum,
          questions_count: Fixnum,
          comments_count: Fixnum,
          created_at: feed.created_at.to_i,
          updated_at: feed.updated_at.to_i,
          created_by: {
            id: feed.created_by.to_param,
            email: feed.created_by.email
          }
        }
      )
    end
  end

  describe 'PUT /api/v1/user/stars/feeds/:feed_id' do
    it 'returns the created star' do
      create(:membership, channel: feed.channel, user: user)
      put "/api/v1/user/stars/feeds/#{feed.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        created_at: Fixnum,
        updated_at: Fixnum,
        feed: {
          id: feed.to_param,
          text: feed.text,
          checks_count: Fixnum,
          crosses_count: Fixnum,
          questions_count: Fixnum,
          comments_count: Fixnum,
          created_at: feed.created_at.to_i,
          updated_at: feed.updated_at.to_i,
          created_by: {
            id: feed.created_by.to_param,
            email: feed.created_by.email
          }
        }
      )
    end
  end
end

require 'rails_helper'

RSpec.describe 'Api::V1::AuthenticatedUsers::Marks', type: :request do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
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
      mark: {
        symbol: String,
        created_at: Fixnum,
        updated_at: Fixnum
      },
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

  describe 'GET /api/v1/user/marked_feeds' do
    it 'returns feeds user marked' do
      create(:mark, feed: feed, user: user)
      get '/api/v1/user/marked_feeds', {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/user/marked_feeds/:id' do
    it 'returns the marked feed' do
      create(:mark, feed: feed, user: user)
      get "/api/v1/user/marked_feeds/#{feed.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'PUT /api/v1/user/marked_feeds/:feed_id' do
    it 'returns the marked feed' do
      create(:membership, channel: feed.channel, user: user)
      put "/api/v1/user/marked_feeds/#{feed.to_param}", attributes_for(:mark),
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

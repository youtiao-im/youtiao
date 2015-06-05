require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      id: String,
      text: String,
      created_at: Fixnum,
      updated_at: Fixnum,
      created_by: {
        id: String,
        email: String,
        created_at: Fixnum,
        updated_at: Fixnum
      }
    }
  end

  before do
    create(:membership, channel: feed.channel, user: user)
  end

  describe 'GET /api/v1/feeds/:feed_id/comments' do
    it 'returns comments of the requested feed' do
      create(:comment, feed: feed)
      get "/api/v1/feeds/#{feed.to_param}/comments", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/comments/:id' do
    it 'returns the requested comment' do
      comment = create(:comment, feed: feed)
      get "/api/v1/comments/#{comment.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'POST /api/v1/feeds/:feed_id/comments' do
    it 'returns the created comment' do
      post "/api/v1/feeds/#{feed.to_param}/comments",
           attributes_for(:comment),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

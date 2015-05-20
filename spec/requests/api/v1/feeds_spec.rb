require 'rails_helper'

RSpec.describe 'Api::V1::Feeds', type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  before do
    create(:admin_membership, channel: channel, user: user)
  end

  describe 'GET /api/v1/channels/:channel_id/feeds' do
    it 'returns feeds of the requested channel' do
      feed = create(:feed, channel: channel)
      get "/api/v1/channels/#{channel.to_param}/feeds", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
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
        ]
      )
    end
  end

  describe 'GET /api/v1/feeds/:id' do
    it 'returns the requested feed' do
      feed = create(:feed, channel: channel)
      get "/api/v1/feeds/#{feed.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
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
      )
    end
  end

  describe 'POST /api/v1/channels/:channel_id/feeds' do
    it 'returns the created feed' do
      post "/api/v1/channels/#{channel.to_param}/feeds",
           attributes_for(:feed),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        id: String,
        text: String,
        checks_count: Fixnum,
        crosses_count: Fixnum,
        questions_count: Fixnum,
        comments_count: Fixnum,
        created_at: Fixnum,
        updated_at: Fixnum,
        created_by: {
          id: user.to_param,
          email: user.email
        }
      )
    end
  end
end

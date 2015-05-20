require 'rails_helper'

RSpec.describe 'Api::V1::AuthenticatedUsers::Marks', type: :request do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET /api/v1/user/marks' do
    it 'returns marks of the requested feed' do
      mark = create(:mark, feed: feed, user: user)
      get '/api/v1/user/marks', {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        [
          {
            symbol: mark.symbol,
            created_at: mark.created_at.to_i,
            updated_at: mark.updated_at.to_i,
            feed: {
              id: feed.to_param,
              text: feed.text,
              checks_count: Fixnum,
              crosses_count: Fixnum,
              questions_count: Fixnum,
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

  describe 'GET /api/v1/user/marks/feeds/:feed_id' do
    it 'returns the requested mark' do
      mark = create(:mark, feed: feed, user: user)
      get "/api/v1/user/marks/feeds/#{feed.to_param}", {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        symbol: mark.symbol,
        created_at: mark.created_at.to_i,
        updated_at: mark.updated_at.to_i,
        feed: {
          id: feed.to_param,
          text: feed.text,
          checks_count: Fixnum,
          crosses_count: Fixnum,
          questions_count: Fixnum,
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

  describe 'PUT /api/v1/user/marks/feeds/:feed_id' do
    it 'returns the created mark' do
      create(:membership, channel: feed.channel, user: user)
      put "/api/v1/user/marks/feeds/#{feed.to_param}", attributes_for(:mark),
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        symbol: String,
        created_at: Fixnum,
        updated_at: Fixnum,
        feed: {
          id: feed.to_param,
          text: feed.text,
          checks_count: Fixnum,
          crosses_count: Fixnum,
          questions_count: Fixnum,
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

  describe 'PATCH /api/v1/user/marks/feeds/:feed_id' do
    it 'returns the updated mark' do
      create(:membership, channel: feed.channel, user: user)
      mark = create(:mark, feed: feed, user: user)
      patch "/api/v1/user/marks/feeds/#{feed.to_param}", attributes_for(:mark),
            'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(
        symbol: String,
        created_at: mark.created_at.to_i,
        updated_at: Fixnum,
        feed: {
          id: feed.to_param,
          text: feed.text,
          checks_count: Fixnum,
          crosses_count: Fixnum,
          questions_count: Fixnum,
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

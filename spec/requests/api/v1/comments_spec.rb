require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  let(:user) { create(:user) }
  let(:bulletin) { create(:bulletin) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      type: 'Comment',
      id: String,
      bulletin_id: String,
      text: String,
      created_by_type: String,
      created_by_id: String,
      created_at: String,
      updated_at: String,
      created_by: {
        type: 'Membership',
        id: String,
        group_id: String,
        user_id: String,
        role: String,
        created_at: String,
        updated_at: String
      }.ignore_extra_keys!
    }
  end

  before do
    create(:membership, group: bulletin.group, user: user)
  end

  describe 'GET /api/v1/bulletins/:bulletin_id/comments' do
    it 'returns comments of the requested bulletin' do
      create(:comment, bulletin: bulletin)
      get "/api/v1/bulletins/#{bulletin.to_param}/comments",
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/comments/:id' do
    it 'returns the requested comment' do
      comment = create(:comment, bulletin: bulletin)
      get "/api/v1/comments/#{comment.to_param}",
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'POST /api/v1/bulletins/:bulletin_id/comments' do
    it 'returns the created comment' do
      post "/api/v1/bulletins/#{bulletin.to_param}/comments",
           attributes_for(:comment),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

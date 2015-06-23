require 'rails_helper'

RSpec.describe 'Api::V1::Bulletins', type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      type: 'Bulletin',
      id: String,
      group_id: String,
      text: String,
      created_by_id: String,
      checks_count: Fixnum,
      crosses_count: Fixnum,
      comments_count: Fixnum,
      created_at: String,
      updated_at: String,
      group: {
        type: 'Group',
        id: String,
        name: String,
        memberships_count: Fixnum,
        created_at: String,
        updated_at: String
      },
      created_by: {
        type: 'User',
        id: String,
        email: String,
        name: String,
        avatar_id: nil,
        created_at: String,
        updated_at: String
      }.ignore_extra_keys!
    }.ignore_extra_keys!
  end

  before do
    create(:admin_membership, group: group, user: user)
  end

  describe 'GET /api/v1/bulletins' do
    it 'returns bulletins' do
      create(:bulletin, group: group)
      get '/api/v1/bulletins',
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/groups/:group_id/bulletins' do
    it 'returns bulletins' do
      create(:bulletin, group: group)
      get "/api/v1/groups/#{group.to_param}/bulletins",
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/bulletins/:id' do
    it 'returns the requested bulletin' do
      bulletin = create(:bulletin, group: group)
      get "/api/v1/bulletins/#{bulletin.to_param}",
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'POST /api/v1/groups/:group_id/bulletins' do
    it 'returns the created bulletin' do
      post "/api/v1/groups/#{group.to_param}/bulletins",
           attributes_for(:bulletin),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'POST /api/v1/bulletins/:id/stamp' do
    it 'returns the stamped bulletin' do
      bulletin = create(:bulletin, group: group)
      post "/api/v1/bulletins/#{bulletin.to_param}/stamp",
           attributes_for(:stamp),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Api::V1::Groups', type: :request do
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      type: 'Group',
      id: String,
      name: String,
      memberships_count: Fixnum,
      created_at: String,
      updated_at: String
    }.ignore_extra_keys!
  end

  describe 'GET /api/v1/groups' do
    it 'returns groups ' do
      group = create(:group)
      create(:membership, group: group, user: user)
      get '/api/v1/groups',
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end

  describe 'GET /api/v1/groups/:id' do
    it 'returns the requested group' do
      group = create(:group)
      create(:membership, group: group, user: user)
      get "/api/v1/groups/#{group.to_param}",
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'POST /api/v1/groups' do
    it 'returns the created group' do
      post '/api/v1/groups',
           attributes_for(:group),
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end

  describe 'POST /api/v1/groups/:id/join' do
    it 'returns the created group' do
      group = create(:group)
      post "/api/v1/groups/#{group.to_param}/join",
           {},
           'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression(json_expression)
    end
  end
end

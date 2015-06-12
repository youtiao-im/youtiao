require 'rails_helper'

RSpec.describe 'Api::V1::Memberships', type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      type: 'Membership',
      id: String,
      group_id: String,
      user_id: String,
      role: String,
      created_at: String,
      updated_at: String,
      user: {
        type: 'User',
        id: String,
        email: String,
        created_at: String,
        updated_at: String
      }
    }.ignore_extra_keys!
  end

  before do
    create(:membership, group: group, user: user)
  end

  describe 'GET /api/v1/groups/:group_id/memberships' do
    it 'returns memberships of the requested group' do
      get "/api/v1/groups/#{group.to_param}/memberships",
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end
end

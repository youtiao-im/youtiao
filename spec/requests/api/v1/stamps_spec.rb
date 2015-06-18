require 'rails_helper'

RSpec.describe 'Api::V1::Stamps', type: :request do
  let(:user) { create(:user) }
  let(:bulletin) { create(:bulletin) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  let(:json_expression) do
    {
      type: 'Stamp',
      id: String,
      bulletin_id: String,
      created_by_id: String,
      symbol: String,
      created_at: String,
      updated_at: String,
      created_by: {
        type: 'User',
        id: String,
        email: String,
        name: String,
        avatar_id: nil,
        created_at: String,
        updated_at: String
      }.ignore_extra_keys!
    }
  end

  before do
    create(:admin_membership, group: bulletin.group, user: user)
  end

  describe 'GET /api/v1/bulletins/:bulletin_id/stamps' do
    it 'returns stamps of the requested bulletin' do
      create(:stamp, bulletin: bulletin)
      get "/api/v1/bulletins/#{bulletin.to_param}/stamps",
          {},
          'Authorization' => "Bearer #{access_token}"
      expect(response.body).to match_json_expression([json_expression])
    end
  end
end

require 'rails_helper'

RSpec.describe V1::StampsAPI, type: :request do
  let(:user) { create(:user) }
  let(:bulletin) { create(:bulletin) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET stamps.list' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        get '/api/v1/stamps.list'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing bulletin' do
        it 'responds with :not_found' do
          get '/api/v1/stamps.list',
              bulletin_id: 0,
              access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing bulletin' do
        context 'when current user is NOT an admin of bulletin.group' do
          before do
            create(:membership, group: bulletin.group, user: user)
          end

          it 'responds with :forbidden' do
            get '/api/v1/stamps.list',
                bulletin_id: bulletin.to_param,
                access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is an admin of bulletin.group' do
          before do
            create(:admin_membership, group: bulletin.group, user: user)
          end

          it 'responds with :ok' do
            get '/api/v1/stamps.list',
                bulletin_id: bulletin.to_param,
                access_token: access_token
            expect(response).to have_http_status(:ok)
          end

          it 'returns stamps of the bulletin' do
            stamp = create(:stamp, bulletin: bulletin)
            get '/api/v1/stamps.list',
                bulletin_id: bulletin.to_param,
                access_token: access_token
            expect(response.body).to match_json_expression(
              [
                {
                  type: 'Stamp',
                  id: stamp.to_param
                }.ignore_extra_keys!
              ])
          end
        end
      end
    end
  end
end

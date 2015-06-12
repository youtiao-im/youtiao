require 'rails_helper'

RSpec.describe Api::V1::StampsController, type: :controller do
  let(:user) { create(:user) }
  let(:bulletin) { create(:bulletin) }

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index, bulletin_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a bulletin not exists' do
        it 'responds with :not_found' do
          get :index, bulletin_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a bulletin exists' do
        context 'when bulletin.group is not affiliated with user' do
          it 'responds with :forbidden' do
            get :index, bulletin_id: bulletin.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when bulletin.group is affiliated with user' do
          context 'when user is not an admin of group' do
            it 'responds with :forbidden' do
              create(:membership, group: bulletin.group, user: user)
              get :index, bulletin_id: bulletin.to_param
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when user is an admin of group' do
            before do
              create(:admin_membership, group: bulletin.group, user: user)
            end

            it 'responds with :ok' do
              get :index, bulletin_id: bulletin.to_param
              expect(response).to have_http_status(:ok)
            end

            it 'decorates stamps of bulletin as #stamps' do
              stamp = create(:stamp, bulletin: bulletin)
              get :index, bulletin_id: bulletin.to_param
              expect(controller.stamps).to be_decorated
              expect(controller.stamps).to match_array([stamp])
            end
          end
        end
      end
    end
  end
end

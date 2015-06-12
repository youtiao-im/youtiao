require 'rails_helper'

RSpec.describe Api::V1::MembershipsController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index, group_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a group not exists' do
        it 'responds with :not_found' do
          get :index, group_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a group exists' do
        context 'when group is not affiliated with user' do
          it 'responds with :forbidden' do
            get :index, group_id: group.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when group is affiliated with user' do
          it 'responds with :ok' do
            create(:membership, group: group, user: user)
            get :index, group_id: group.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates memberships of group as #memberships' do
            membership = create(:membership, group: group, user: user)
            get :index, group_id: group.to_param
            expect(controller.memberships).to be_decorated
            expect(controller.memberships).to match_array([membership])
          end
        end
      end
    end
  end
end

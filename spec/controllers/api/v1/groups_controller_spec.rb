require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      it 'responds with :ok' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'decorates groups of user as #groups' do
        create(:membership, group: group, user: user)
        get :index
        expect(controller.groups).to be_decorated
        expect(controller.groups).to match_array([group])
      end
    end
  end

  describe 'GET #show' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :show, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a group not exists' do
        it 'responds with :not_found' do
          get :show, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a group exists' do
        context 'when group is not affiliated with user' do
          it 'responds with :forbidden' do
            get :show, id: group.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when group is affiliated with user' do
          before do
            create(:membership, group: group, user: user)
          end

          it 'responds with :ok' do
            get :show, id: group.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates the group as #group' do
            get :show, id: group.to_param
            expect(controller.group).to be_decorated
            expect(controller.group).to eq(group)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'with invalid attributes' do
        it 'responds with :unprocessable_entity' do
          post :create, attributes_for(:invalid_group)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with valid attributes' do
        it 'responds with :ok' do
          post :create, attributes_for(:group)
          expect(response).to have_http_status(:ok)
        end

        it 'creates a new group' do
          expect do
            post :create, attributes_for(:group)
          end.to change(Group, :count).by(1)
        end

        it 'adds user to the created group as an owner' do
          post :create, attributes_for(:group)
          expect(Group.last.current_membership).to be_owner
        end

        it 'decorates the created group as #group' do
          post :create, attributes_for(:group)
          expect(controller.group).to be_decorated
          expect(controller.group).to eq(Group.last)
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        patch :update, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a group not exists' do
        it 'responds with :not_found' do
          patch :update, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a group exists' do
        context 'when group is not affiliated with user' do
          it 'responds with :forbidden' do
            patch :update, id: group.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when group is affiliated with user 'do
          context 'when user is not an admin of group' do
            before do
              create(:membership, group: group, user: user)
            end

            it 'responds with :forbidden' do
              patch :update, id: group.to_param
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when user is an admin of group' do
            before do
              create(:admin_membership, group: group, user: user)
            end

            it 'responds with :ok' do
              patch :update, { id: group.to_param }.merge(
                attributes_for(:group))
              expect(response).to have_http_status(:ok)
            end

            it 'decorates the updated group as #group' do
              patch :update, { id: group.to_param }.merge(
                attributes_for(:group))
              expect(controller.group).to be_decorated
              expect(controller.group).to eq(group)
            end
          end
        end
      end
    end
  end

  describe 'POST #join' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        post :join, code: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a group not exists' do
        it 'responds with :not_found' do
          post :join, code: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a group exists' do
        context 'for a group affiliated with user' do
          before do
            create(:membership, group: group, user: user)
          end

          it 'responds with :ok' do
            post :join, code: group.code
            expect(response).to have_http_status(:ok)
          end

          it 'does not create a new membership' do
            expect do
              post :join, code: group.code
            end.to_not change(Membership, :count)
          end

          it 'decorates the group as #group' do
            post :join, code: group.code
            expect(controller.group).to be_decorated
            expect(controller.group).to eq(group)
          end
        end

        context 'for a group not affiliated with user' do
          it 'responds with :ok' do
            post :join, code: group.code
            expect(response).to have_http_status(:ok)
          end

          it 'creates a new membership' do
            expect do
              post :join, code: group.code
            end.to change(Membership, :count).by(1)
          end

          it 'decorates the joined group as #group' do
            post :join, code: group.code
            expect(controller.group).to be_decorated
            expect(controller.group).to eq(group)
          end
        end
      end
    end
  end
end

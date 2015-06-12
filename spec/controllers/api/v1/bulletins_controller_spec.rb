require 'rails_helper'

RSpec.describe Api::V1::BulletinsController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:bulletin) { create(:bulletin) }

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
        create(:membership, group: bulletin.group, user: user)
      end

      it 'responds with :ok' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'decorates bulletins of user as #bulletins' do
        get :index
        expect(controller.bulletins).to be_decorated
        expect(controller.bulletins).to eq([bulletin])
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

      context 'for a bulletin not exists' do
        it 'responds with :not_found' do
          get :show, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a bulletin exists' do
        context 'when bulletin.group is not affiliated with user' do
          it 'responds with :forbidden' do
            get :show, id: bulletin.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when bulletin.group is affiliated with user' do
          before do
            create(:membership, group: bulletin.group, user: user)
          end

          it 'responds with :ok' do
            get :show, id: bulletin.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates bulletin as #bulletin' do
            get :show, id: bulletin.to_param
            expect(controller.bulletin).to be_decorated
            expect(controller.bulletin).to eq(bulletin)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        post :create, group_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a group not exists' do
        it 'responds with :not_found' do
          post :create, group_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a group exists' do
        context 'when group is not affiliated with user' do
          it 'responds with :forbidden' do
            post :create, group_id: group.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when group is affiliated with user' do
          context 'when user is not an admin of group' do
            it 'responds with :forbidden' do
              create(:membership, group: group, user: user)
              post :create, group_id: group.to_param
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when user is an admin of group' do
            before do
              create(:admin_membership, group: group, user: user)
            end

            context 'with invalid attributes' do
              it 'responds with :bad_request' do
                post :create, { group_id: group.to_param }.merge(
                  attributes_for(:invalid_bulletin))
                expect(response).to have_http_status(:bad_request)
              end
            end

            context 'with valid attributes' do
              it 'responds with :ok' do
                post :create, { group_id: group.to_param }.merge(
                  attributes_for(:bulletin))
                expect(response).to have_http_status(:ok)
              end

              it 'creates a new bulletin' do
                expect do
                  post :create, { group_id: group.to_param }.merge(
                    attributes_for(:bulletin))
                end.to change(Bulletin, :count).by(1)
              end

              it 'decorates the created bulletin as #bulletin' do
                post :create, { group_id: group.to_param }.merge(
                  attributes_for(:bulletin))
                expect(controller.bulletin).to be_decorated
                expect(controller.bulletin).to eq(Bulletin.last)
              end
            end
          end
        end
      end
    end
  end

  describe 'POST #stamp' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        post :stamp, id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a bulletin not exists' do
        it 'responds with :not_found' do
          post :stamp, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a bulletin exists' do
        context 'when bulletin.group is not affiliated with user' do
          it 'responds with :forbidden' do
            post :stamp, id: bulletin.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when bulletin.group is affiliated with user' do
          let!(:membership) do
            create(:membership, group: bulletin.group, user: user)
          end

          context 'with invalid attributes' do
            it 'responds with :bad_request' do
              post :stamp, { id: bulletin.to_param }.merge(
                attributes_for(:invalid_stamp))
              expect(response).to have_http_status(:bad_request)
            end
          end

          context 'with valid attributes' do
            context 'when bulletin is stamped by user' do
              it 'responds with :ok' do
                create(:stamp, bulletin: bulletin, created_by: membership)
                post :stamp, { id: bulletin.to_param }.merge(
                  attributes_for(:stamp))
                expect(response).to have_http_status(:ok)
              end

              it 'updates the existing stamp' do
                create(:stamp, bulletin: bulletin, created_by: membership)
                expect do
                  post :stamp, { id: bulletin.to_param }.merge(
                    attributes_for(:stamp))
                end.to_not change(Stamp, :count)
              end

              it 'decorates the stamped bulletin as #bulletin' do
                create(:stamp, bulletin: bulletin, created_by: membership)
                post :stamp, { id: bulletin.to_param }.merge(
                  attributes_for(:stamp))
                expect(controller.bulletin).to be_decorated
                expect(controller.bulletin).to eq(bulletin)
              end
            end

            context 'when bulletin is not stamped by user' do
              it 'responds with :ok' do
                post :stamp, { id: bulletin.to_param }.merge(
                  attributes_for(:stamp))
                expect(response).to have_http_status(:ok)
              end

              it 'creates a new stamp' do
                expect do
                  post :stamp, { id: bulletin.to_param }.merge(
                    attributes_for(:stamp))
                end.to change(Stamp, :count).by(1)
              end

              it 'decorates the stamped bulletin as #bulletin' do
                post :stamp, { id: bulletin.to_param }.merge(
                  attributes_for(:stamp))
                expect(controller.bulletin).to be_decorated
                expect(controller.bulletin).to eq(bulletin)
              end
            end
          end
        end
      end
    end
  end
end

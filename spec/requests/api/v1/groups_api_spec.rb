require 'rails_helper'

RSpec.describe V1::GroupsAPI, type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET groups.list' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        get '/api/v1/groups.list'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      it 'responds with :ok' do
        get '/api/v1/groups.list',
            access_token: access_token
        expect(response).to have_http_status(:ok)
      end

      it 'returns groups current user joined' do
        create(:membership, group: group, user: user)
        get '/api/v1/groups.list',
            access_token: access_token
        expect(response.body).to match_json_expression(
          [
            {
              type: 'Group',
              id: group.to_param,
              current_membership: Hash
            }.ignore_extra_keys!
          ])
      end
    end
  end

  describe 'POST groups.create' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/groups.create'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'with INVALID attributes' do
        it 'responds with :unprocessable_entity' do
          post '/api/v1/groups.create',
               attributes_for(:invalid_group).merge(
                 access_token: access_token)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with valid attributes' do
        it 'responds with :ok' do
          post '/api/v1/groups.create',
               attributes_for(:group).merge(
                 access_token: access_token)
          expect(response).to have_http_status(:ok)
        end

        it 'creates a new group' do
          expect do
            post '/api/v1/groups.create',
                 attributes_for(:group).merge(
                   access_token: access_token)
          end.to change(Group, :count).by(1)
        end

        it 'creates a new membership' do
          expect do
            post '/api/v1/groups.create',
                 attributes_for(:group).merge(
                   access_token: access_token)
          end.to change(Membership, :count).by(1)
        end

        it 'adds current user to the created group as an owner' do
          post '/api/v1/groups.create',
               attributes_for(:group).merge(
                 access_token: access_token)
          expect(Membership.last.group).to eq(Group.last)
          expect(Membership.last.user).to eq(user)
          expect(Membership.last.role).to eq(:owner)
        end

        it 'returns the created group' do
          post '/api/v1/groups.create',
               attributes_for(:group).merge(
                 access_token: access_token)
          expect(response.body).to match_json_expression(
            {
              type: 'Group',
              current_membership: Hash
            }.ignore_extra_keys!)
        end
      end
    end
  end

  describe 'POST groups.update' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/groups.update'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing group' do
        it 'responds with :not_found' do
          post '/api/v1/groups.update',
               id: 0,
               access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing group' do
        context 'when current user is NOT an admin of the group' do
          before do
            create(:membership, group: group, user: user)
          end

          it 'responds with :forbidden' do
            post '/api/v1/groups.update',
                 id: group.to_param,
                 access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is an admin of the group' do
          before do
            create(:admin_membership, group: group, user: user)
          end

          context 'with INVALID attributes' do
            it 'responds with :unprocessable_entity' do
              post '/api/v1/groups.update',
                   attributes_for(:invalid_group).merge(
                     id: group.to_param,
                     access_token: access_token)
              expect(response).to have_http_status(:unprocessable_entity)
            end
          end

          context 'with valid attributes' do
            it 'responds with :ok' do
              post '/api/v1/groups.update',
                   attributes_for(:group).merge(
                     id: group.to_param,
                     access_token: access_token)
              expect(response).to have_http_status(:ok)
            end

            it 'updates the group' do
              post '/api/v1/groups.update',
                   attributes_for(:group).merge(
                     id: group.to_param,
                     access_token: access_token)
              expect(Group.find(group.id).updated_at).to_not eq(
                group.updated_at)
            end

            it 'returns the updated group' do
              post '/api/v1/groups.update',
                   attributes_for(:group).merge(
                     id: group.to_param,
                     access_token: access_token)
              expect(response.body).to match_json_expression(
                {
                  type: 'Group',
                  id: group.to_param,
                  current_membership: Hash
                }.ignore_extra_keys!)
            end
          end
        end
      end
    end
  end

  describe 'POST groups.join' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/groups.join'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing group' do
        it 'responds with :not_found' do
          post '/api/v1/groups.join',
               code: 0,
               access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing group' do
        context 'when current user has ALREADY joined the group' do
          before do
            create(:membership, group: group, user: user)
          end

          it 'responds with :ok' do
            post '/api/v1/groups.join',
                 code: group.code,
                 access_token: access_token
            expect(response).to have_http_status(:ok)
          end

          it 'does not creates a new membership' do
            expect do
              post '/api/v1/groups.join',
                   code: group.code,
                   access_token: access_token
            end.to_not change(Membership, :count)
          end

          it 'returns the group' do
            post '/api/v1/groups.join',
                 code: group.code,
                 access_token: access_token
            expect(response.body).to match_json_expression(
              {
                type: 'Group',
                id: group.to_param,
                current_membership: Hash
              }.ignore_extra_keys!)
          end
        end

        context 'when current user has not joined the group' do
          it 'responds with :ok' do
            post '/api/v1/groups.join',
                 code: group.code,
                 access_token: access_token
            expect(response).to have_http_status(:ok)
          end

          it 'creates a new membership' do
            expect do
              post '/api/v1/groups.join',
                   code: group.code,
                   access_token: access_token
            end.to change(Membership, :count).by(1)
          end

          it 'returns the joined group' do
            post '/api/v1/groups.join',
                 code: group.code,
                 access_token: access_token
            expect(response.body).to match_json_expression(
              {
                type: 'Group',
                id: group.to_param,
                current_membership: Hash
              }.ignore_extra_keys!)
          end
        end
      end
    end
  end
end

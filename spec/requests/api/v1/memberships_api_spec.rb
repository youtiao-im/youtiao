require 'rails_helper'

RSpec.describe V1::MembershipsAPI, type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:membership) { create(:membership, group: group) }
  let(:admin_membership) { create(:admin_membership, group: group) }
  let(:owner_membership) { create(:owner_membership, group: group) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  before do
    host! 'api.lvh.me'
  end

  describe 'GET memberships.list' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        get '/v1/memberships.list'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing group' do
        it 'responds with :not_found' do
          get '/v1/memberships.list',
              group_id: 0,
              access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing group' do
        context 'when current user is NOT a member of the group' do
          it 'responds with :forbidden' do
            get '/v1/memberships.list',
                group_id: group.to_param,
                access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is a member of the group' do
          before do
            create(:membership, group: group, user: user)
          end

          it 'responds with :ok' do
            get '/v1/memberships.list',
                group_id: group.to_param,
                access_token: access_token
            expect(response).to have_http_status(:ok)
          end

          it 'returns memberships of the group' do
            get '/v1/memberships.list',
                group_id: group.to_param,
                access_token: access_token
            expect(response.body).to match_json_expression(
              [
                {
                  type: 'Membership'
                }.ignore_extra_keys!
              ])
          end
        end
      end
    end
  end

  describe 'POST memberships.promote' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/v1/memberships.promote'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing membership' do
        it 'responds with :not_found' do
          post '/v1/memberships.promote',
               id: 0,
               access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing membership' do
        context 'when current user is NOT an owner of the group' do
          it 'responds with :forbidden' do
            post '/v1/memberships.promote',
                 id: membership.to_param,
                 access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is an owner of the group' do
          before do
            create(:owner_membership, group: group, user: user)
          end

          context 'when the target membership is an owner membership' do
            it 'responds with :forbidden' do
              post '/v1/memberships.promote',
                   id: owner_membership.to_param,
                   access_token: access_token
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when the target membership is not an owner membership' do
            it 'responds with :ok' do
              post '/v1/memberships.promote',
                   id: membership.to_param,
                   access_token: access_token
              expect(response).to have_http_status(:ok)
            end

            it 'returns the promoted membership' do
              post '/v1/memberships.promote',
                   id: membership.to_param,
                   access_token: access_token
              expect(response.body).to match_json_expression(
                {
                  type: 'Membership',
                  id: membership.to_param,
                  role: 'admin',
                  user: Hash
                }.ignore_extra_keys!)
            end
          end
        end
      end
    end
  end

  describe 'POST memberships.demote' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/v1/memberships.demote'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing membership' do
        it 'responds with :not_found' do
          post '/v1/memberships.demote',
               id: 0,
               access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing membership' do
        context 'when current user is NOT an owner of the group' do
          it 'responds with :forbidden' do
            post '/v1/memberships.demote',
                 id: membership.to_param,
                 access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is an owner of the group' do
          before do
            create(:owner_membership, group: group, user: user)
          end

          context 'when the target membership is an owner membership' do
            it 'responds with :forbidden' do
              post '/v1/memberships.demote',
                   id: owner_membership.to_param,
                   access_token: access_token
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when the target membership is not an owner membership' do
            it 'responds with :ok' do
              post '/v1/memberships.demote',
                   id: membership.to_param,
                   access_token: access_token
              expect(response).to have_http_status(:ok)
            end

            it 'returns the promoted membership' do
              post '/v1/memberships.demote',
                   id: membership.to_param,
                   access_token: access_token
              expect(response.body).to match_json_expression(
                {
                  type: 'Membership',
                  id: membership.to_param,
                  role: 'member',
                  user: Hash
                }.ignore_extra_keys!)
            end
          end
        end
      end
    end
  end
end

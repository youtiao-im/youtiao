require 'rails_helper'

RSpec.describe V1::BulletinsAPI, type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:bulletin) { create(:bulletin) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

  describe 'GET bulletins.list' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        get '/api/v1/bulletins.list'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'given :group_id parameter' do
        context 'for a NON-existing group' do
          it 'responds with :not_found' do
            get '/api/v1/bulletins.list',
                group_id: 0,
                access_token: access_token
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'for an existing group' do
          context 'when current user is NOT a member of the group' do
            it 'responds with :forbidden' do
              get '/api/v1/bulletins.list',
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
              get '/api/v1/bulletins.list',
                  group_id: group.to_param,
                  access_token: access_token
              expect(response).to have_http_status(:ok)
            end

            it 'returns bulletins of the group' do
              bulletin = create(:bulletin, group: group)
              get '/api/v1/bulletins.list',
                  group_id: group.to_param,
                  access_token: access_token
              expect(response.body).to match_json_expression(
                [
                  {
                    type: 'Bulletin',
                    id: bulletin.to_param
                  }.ignore_extra_keys!
                ])
            end
          end
        end
      end

      context 'given NO :group_id parameter' do
        it 'responds with :ok' do
          get '/api/v1/bulletins.list',
              access_token: access_token
          expect(response).to have_http_status(:ok)
        end

        it 'returns bulletins of groups current user joined' do
          create(:membership, group: bulletin.group, user: user)
          get '/api/v1/bulletins.list',
              access_token: access_token
          expect(response.body).to match_json_expression(
            [
              {
                type: 'Bulletin',
                id: bulletin.to_param
              }.ignore_extra_keys!
            ])
        end
      end
    end
  end

  describe 'POST bulletins.create' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/bulletins.create'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing group' do
        it 'responds with :not_found' do
          post '/api/v1/bulletins.create',
               group_id: 0,
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
            post '/api/v1/bulletins.create',
                 group_id: group.to_param,
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
              post '/api/v1/bulletins.create',
                   attributes_for(:invalid_bulletin).merge(
                     group_id: group.to_param,
                     access_token: access_token)
              expect(response).to have_http_status(:unprocessable_entity)
            end
          end

          context 'with valid attributes' do
            it 'responds with :ok' do
              post '/api/v1/bulletins.create',
                   attributes_for(:bulletin).merge(
                     group_id: group.to_param,
                     access_token: access_token)
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new bulletin' do
              expect do
                post '/api/v1/bulletins.create',
                     attributes_for(:bulletin).merge(
                       group_id: group.to_param,
                       access_token: access_token)
              end.to change(Bulletin, :count).by(1)
            end

            it 'returns the created bulletin' do
              post '/api/v1/bulletins.create',
                   attributes_for(:bulletin).merge(
                     group_id: group.to_param,
                     access_token: access_token)
              expect(response.body).to match_json_expression(
                {
                  type: 'Bulletin'
                }.ignore_extra_keys!)
            end
          end
        end
      end
    end
  end

  describe 'POST bulletins.stamp' do
    context 'when NOT authenticated' do
      it 'responds with :unauthorized' do
        post '/api/v1/bulletins.stamp'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      context 'for a NON-existing bulletin' do
        it 'responds with :not_found' do
          post '/api/v1/bulletins.stamp',
               id: 0,
               symbol: :check,
               access_token: access_token
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for an existing bulletin' do
        context 'when current user is NOT a member of bulletin.group' do
          it 'responds with :forbidden' do
            post '/api/v1/bulletins.stamp',
                 id: bulletin.to_param,
                 symbol: :check,
                 access_token: access_token
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when current user is a member of bulletin.group' do
          before do
            create(:membership, group: bulletin.group, user: user)
          end

          context 'when current user has ALREADY stamped the bulletin' do
            before do
              create(:stamp, bulletin: bulletin, created_by: user)
            end

            it 'responds with :ok' do
              post '/api/v1/bulletins.stamp',
                   id: bulletin.to_param,
                   symbol: :check,
                   access_token: access_token
              expect(response).to have_http_status(:ok)
            end

            it 'does not create a new stamp' do
              expect do
                post '/api/v1/bulletins.stamp',
                     id: bulletin.to_param,
                     symbol: :check,
                     access_token: access_token
              end.to_not change(Stamp, :count)
            end

            it 'returns the bulletin' do
              post '/api/v1/bulletins.stamp',
                   id: bulletin.to_param,
                   symbol: :check,
                   access_token: access_token
              expect(response.body).to match_json_expression(
                {
                  type: 'Bulletin',
                  id: bulletin.to_param,
                  current_stamp: Hash
                }.ignore_extra_keys!)
            end
          end

          context 'when current user has not stamped the bulletin' do
            it 'responds with :ok' do
              post '/api/v1/bulletins.stamp',
                   id: bulletin.to_param,
                   symbol: :check,
                   access_token: access_token
              expect(response).to have_http_status(:ok)
            end

            it 'creates a new stamp' do
              expect do
                post '/api/v1/bulletins.stamp',
                     id: bulletin.to_param,
                     symbol: :check,
                     access_token: access_token
              end.to change(Stamp, :count).by(1)
            end

            it 'returns the stamped bulletin' do
              post '/api/v1/bulletins.stamp',
                   id: bulletin.to_param,
                   symbol: :check,
                   access_token: access_token
              expect(response.body).to match_json_expression(
                {
                  type: 'Bulletin',
                  id: bulletin.to_param,
                  current_stamp: Hash
                }.ignore_extra_keys!)
            end
          end
        end
      end
    end
  end
end

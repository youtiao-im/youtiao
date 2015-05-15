require 'rails_helper'

RSpec.describe Api::V1::Channels::MembershipsController, type: :controller do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

  describe 'GET #index' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :index, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a channel not exists' do
        it 'responds with :not_found' do
          get :index, channel_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a channel exists' do
        context 'when user is not affiliated with channel' do
          it 'responds with :forbidden' do
            get :index, channel_id: channel.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when user is affiliated with channel' do
          before do
            create(:membership, channel: channel, user: user)
          end

          it 'responds with :ok' do
            get :index, channel_id: channel.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates memberships of channel as #memberships' do
            get :index, channel_id: channel.to_param
            expect(controller.memberships).to be_decorated
            expect(controller.memberships).to match_array(
              [Membership.pinpoint(channel.id, user.id)])
          end

          it 'sets pagination headers' do
            get :index, channel_id: channel.to_param
            expect(response.headers['Total']).to_not be_nil
            expect(response.headers['Per-Page']).to_not be_nil
          end
        end
      end
    end
  end

  describe 'GET #show' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :show, channel_id: 0, user_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a channel not exists' do
        it 'responds with :not_found' do
          get :show, channel_id: 0, user_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a channel exists' do
        context 'when user is not affiliated with channel' do
          it 'responds with :forbidden' do
            get :show, channel_id: channel.to_param, user_id: 0
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when user is affiliated with channel' do
          let(:another_user) { another_user = create(:user) }

          before do
            create(:membership, channel: channel, user: user)
          end

          context 'for a user not affiliated with channel' do
            it 'responds with :not_found' do
              get :show,
                  channel_id: channel.to_param,
                  user_id: another_user.to_param
              expect(response).to have_http_status(:not_found)
            end
          end

          context 'for a user affiliated with channel' do
            before do
              create(:membership, channel: channel, user: another_user)
            end

            it 'responds with :ok' do
              get :show,
                  channel_id: channel.to_param,
                  user_id: another_user.to_param
              expect(response).to have_http_status(:ok)
            end

            it 'decorates membership as #membership' do
              get :show,
                  channel_id: channel.to_param,
                  user_id: another_user.to_param
              expect(controller.membership).to be_decorated
              expect(controller.membership).to eq(
                Membership.pinpoint(channel.id, another_user.id))
            end
          end
        end
      end
    end
  end
end

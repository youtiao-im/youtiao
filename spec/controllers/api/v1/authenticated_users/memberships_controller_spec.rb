require 'rails_helper'

RSpec.describe Api::V1::AuthenticatedUsers::MembershipsController,\
               type: :controller do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

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

      it 'decorates memberships of user as #memberships' do
        membership = create(:membership, user: user)
        get :index
        expect(controller.memberships).to be_decorated
        expect(controller.memberships).to match_array([membership])
      end

      it 'sets pagination headers' do
        get :index
        expect(response.headers['Total']).to_not be_nil
        expect(response.headers['Per-Page']).to_not be_nil
      end
    end
  end

  describe 'GET #show' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :show, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a channel not affiliated with user' do
        it 'responds with :not_found' do
          get :show, channel_id: channel.to_param
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a channel affiliated with user' do
        before do
          create(:membership, channel: channel, user: user)
        end

        it 'responds with :ok' do
          get :show, channel_id: channel.to_param
          expect(response).to have_http_status(:ok)
        end

        it 'decorates membership as #membership' do
          get :show, channel_id: channel.to_param
          expect(controller.membership).to be_decorated
          expect(controller.membership).to eq(
            Membership.pinpoint(channel.id, user.id))
        end
      end
    end
  end

  describe 'PUT #create' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        put :create, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a channel affiliated with user' do
        it 'responds with :conflict' do
          create(:membership, channel: channel, user: user)
          put :create, channel_id: channel.to_param
          expect(response).to have_http_status(:conflict)
        end
      end

      context 'for a channel not affiliated with user' do
        it 'responds with :ok' do
          put :create, channel_id: channel.to_param
          expect(response).to have_http_status(:ok)
        end

        it 'creates a new membership' do
          expect do
            put :create, channel_id: channel.to_param
          end.to change(Membership, :count).by(1)
        end

        it 'decorates the created membership as #membership' do
          put :create, channel_id: channel.to_param
          expect(controller.membership).to be_decorated
          expect(controller.membership).to eq(Membership.last)
        end
      end
    end
  end
end

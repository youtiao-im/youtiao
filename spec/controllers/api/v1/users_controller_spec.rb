require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        get :show
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      it 'responds with :ok' do
        get :show
        expect(response).to have_http_status(:ok)
      end

      it 'decorates current user as #user' do
        get :show
        expect(controller.user).to be_decorated
        expect(controller.user).to eq(user)
      end
    end
  end
end

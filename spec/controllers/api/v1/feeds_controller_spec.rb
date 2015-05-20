require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:feed) { create(:feed) }

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
        context 'when channel is not affiliated with user' do
          it 'responds with :forbidden' do
            get :index, channel_id: channel.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when channel is affiliated with user' do
          before do
            create(:membership, channel: channel, user: user)
          end

          it 'responds with :ok' do
            get :index, channel_id: channel.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates feeds of channel as #feeds' do
            feed = create(:feed, channel: channel)
            get :index, channel_id: channel.to_param
            expect(controller.feeds).to be_decorated
            expect(controller.feeds).to match_array([feed])
          end

          it 'sets pagination headers' do
            get :index, channel_id: channel.to_param
            expect(response.headers['X-Total']).to_not be_nil
            expect(response.headers['X-Per-Page']).to_not be_nil
          end
        end
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

      context 'for a feed not exists' do
        it 'responds with :not_found' do
          get :show, id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a feed exists' do
        context 'when feed belongs to a channel not affiliated with user' do
          it 'responds with :forbidden' do
            get :show, id: feed.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when feed belongs to a channel affiliated with user' do
          before do
            create(:membership, channel: feed.channel, user: user)
          end

          it 'responds with :ok' do
            get :show, id: feed.to_param
            expect(response).to have_http_status(:ok)
          end

          it 'decorates feed as #feed' do
            get :show, id: feed.to_param
            expect(controller.feed).to be_decorated
            expect(controller.feed).to eq(feed)
          end
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when not authenticated' do
      it 'responds with :unauthorized' do
        post :create, channel_id: 0
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      before do
        authenticate user
      end

      context 'for a channel not exists' do
        it 'responds with :not_found' do
          post :create, channel_id: 0
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'for a channel exists' do
        context 'when channel is not affiliated with user' do
          it 'responds with :forbidden' do
            post :create, channel_id: channel.to_param
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when channel is affiliated with user' do
          context 'when user is not an admin of channel' do
            it 'responds with :forbidden' do
              create(:membership, channel: channel, user: user)
              post :create, channel_id: channel.to_param
              expect(response).to have_http_status(:forbidden)
            end
          end

          context 'when user is an admin of channel' do
            before do
              create(:admin_membership, channel: channel, user: user)
            end

            context 'with invalid attributes' do
              it 'responds with :bad_request' do
                post :create, { channel_id: channel.to_param }.merge(
                  attributes_for(:invalid_feed))
                expect(response).to have_http_status(:bad_request)
              end
            end

            context 'with valid attributes' do
              it 'responds with :ok' do
                post :create, { channel_id: channel.to_param }.merge(
                  attributes_for(:feed))
                expect(response).to have_http_status(:ok)
              end

              it 'creates a new feed' do
                expect do
                  post :create, { channel_id: channel.to_param }.merge(
                    attributes_for(:feed))
                end.to change(Feed, :count).by(1)
              end

              it 'decorates the new feed as #feed' do
                post :create, { channel_id: channel.to_param }.merge(
                  attributes_for(:feed))
                expect(controller.feed).to be_decorated
                expect(controller.feed).to eq(Feed.last)
              end
            end
          end
        end
      end
    end
  end
end

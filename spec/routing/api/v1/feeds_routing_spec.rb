require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/channels/1/feeds').to route_to(
        'api/v1/feeds#index', channel_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/channels/1/feeds/1').to route_to(
        'api/v1/feeds#show', channel_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/channels/1/feeds').to route_to(
        'api/v1/feeds#create', channel_id: '1')
    end

    it 'routes to #stamp' do
      expect(post: '/api/v1/channels/1/feeds/1/stamp').to route_to(
        'api/v1/feeds#stamp', channel_id: '1', id: '1')
    end
  end
end

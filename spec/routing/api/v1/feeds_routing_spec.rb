require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/channels/1/feeds').to route_to(
        'api/v1/feeds#index', channel_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/feeds/1').to route_to(
        'api/v1/feeds#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/channels/1/feeds').to route_to(
        'api/v1/feeds#create', channel_id: '1')
    end

    it 'routes to #feedback' do
      expect(post: '/api/v1/feeds/1/feedback').to route_to(
        'api/v1/feeds#feedback', id: '1')
    end
  end
end

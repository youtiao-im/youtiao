require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/channels').to route_to(
        'api/v1/channels#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/v1/channels/1').to route_to(
        'api/v1/channels#show', format: :json, id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/channels').to route_to(
        'api/v1/channels#create', format: :json)
    end

    it 'routes to #subscribe' do
      expect(post: '/api/v1/channels/1/subscribe').to route_to(
        'api/v1/channels#subscribe', format: :json, id: '1')
    end
  end
end

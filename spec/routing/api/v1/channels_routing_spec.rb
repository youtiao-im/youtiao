require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/channels').to route_to(
        'api/v1/channels#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/channels/1').to route_to(
        'api/v1/channels#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/channels').to route_to(
        'api/v1/channels#create')
    end

    it 'routes to #join' do
      expect(post: '/api/v1/channels/1/join').to route_to(
        'api/v1/channels#join', id: '1')
    end
  end
end

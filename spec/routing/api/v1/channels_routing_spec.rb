require 'rails_helper'

RSpec.describe Api::v1::ChannelsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/channels').to route_to(
        'channels#index')
    end

    it 'routes to #show' do
      expect(get: '/channels/1').to route_to(
        'channels#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/channels').to route_to(
        'channels#create')
    end

    it 'routes to #subscribe' do
      expect(post: '/channels/1/subscribe').to route_to(
        'channels#subscribe', id: '1')
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/channels/1/posts').to route_to(
        'api/v1/posts#index', channel_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/posts/1').to route_to(
        'api/v1/posts#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/channels/1/posts').to route_to(
        'api/v1/posts#create', channel_id: '1')
    end

    it 'routes to #feedback' do
      expect(post: '/api/v1/posts/1/feedback').to route_to(
        'api/v1/posts#feedback', id: '1')
    end
  end
end

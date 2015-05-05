require 'rails_helper'

RSpec.describe Api::v1::PostsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/channels/1/posts').to route_to(
        'posts#index', channel_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/posts/1').to route_to(
        'posts#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/channels/1/posts').to route_to(
        'posts#create', channel_id: '1')
    end

    it 'routes to #feedback' do
      expect(post: '/posts/1/feedback').to route_to(
        'channels#subscribe', id: '1')
    end
  end
end

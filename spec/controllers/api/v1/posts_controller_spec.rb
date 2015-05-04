require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe 'GET #index' do
    context 'when access token is nil' do
      it 'responds with :unauthorized'
    end

    context 'when access token has expired' do
      it 'responds with :unauthorized'
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found'
    end

    context 'for not a channel user' do
      it 'responds with :forbidden'
    end

    context 'for a channel user' do
      it 'responds with :ok'
      it 'decorates all posts of the channel as #posts'
    end
  end

  describe 'GET #show' do
    context 'when access token is nil' do
      it 'responds with :unauthorized'
    end

    context 'when access token has expired' do
      it 'responds with :unauthorized'
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found'
    end

    context 'for not a channel user' do
      it 'responds with :forbidden'
    end

    context 'for a channel user' do
      it 'responds with :ok'
      it 'decorates the post as #post'
    end
  end

  describe 'POST #create' do
    context 'when access token is nil' do
      it 'responds with :unauthorized'
    end

    context 'when access token has expired' do
      it 'responds with :unauthorized'
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found'
    end

    context 'for not a channel publisher' do
      it 'responds with :forbidden'
    end

    context 'with invalid params' do
      it 'responds with :bad_request'
    end

    context 'with valid params' do
      it 'responds with :ok'
      it 'creates a new post'
      it 'decorates the new post as #post'
    end
  end

  describe 'POST #feedback' do
    context 'when access token is nil' do
      it 'responds with :unauthorized'
    end

    context 'when access token has expired' do
      it 'responds with :unauthorized'
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found'
    end

    context 'for not a channel user' do
      it 'responds with :forbidden'
    end

    context 'when feedback already exists' do
      it 'responds with :ok'
      it 'does not create any new feedback'
      it 'updates the existing feedback with the new data'
      it 'decorates the updated feedback as #feedback'
    end

    context 'when feedback doest not exist' do
      it 'responds with :ok'
      it 'creates a new feedback'
      it 'decorates the new feedback as #feedback'
    end
  end
end

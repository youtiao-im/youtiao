require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  describe 'GET #index' do
    context 'when access token is nil' do
      it 'responds with :unauthorized'
    end

    context 'when access token has expired' do
      it 'responds with :unauthorized'
    end

    context 'when access token is valid' do
      it 'responds with :ok'
      it 'decorates all channels user subscribed as #channels'
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
      it 'decorates the channel as #channel'
    end
  end

  describe 'POST #create' do
    context 'when access token is nil' do
      it 'responds with :unauthorized'
    end

    context 'when access token has expired' do
      it 'responds with :unauthorized'
    end

    context 'with invalid params' do
      it 'responds with :bad_request'
    end

    context 'with valid params' do
      it 'responds with :ok'
      it 'creates a new channel'
      it 'adds user to the new channel as an admin'
      it 'decorates the new channel as #channel'
    end
  end

  describe 'POST #subscribe' do
    context 'when access token is nil' do
      it 'responds with :unauthorized'
    end

    context 'when access token has expired' do
      it 'responds with :unauthorized'
    end

    context 'for a non-existing channel' do
      it 'responds with :not_found'
    end

    context 'for a channel user' do
      it 'responds with :ok'
      it 'does not create any new channel user'
      it 'decorates the channel as #channel'
    end

    context 'for not a channel user' do
      it 'responds with :ok'
      it 'creates a new channel user'
      it 'adds user to the channel as a subscriber'
      it 'decorates the channel as #channel'
    end
  end
end

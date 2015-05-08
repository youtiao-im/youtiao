class FeedPolicy < ApplicationPolicy
  def index?
    !user.current_channel.channel_user(user).nil?
  end

  def create?
    channel_user = record.channel.channel_user(user)
    channel_user.nil? ? false : channel_user.admin_access?
  end

  def stamp?
    show?
  end

  class Scope < Scope
    def resolve
      user.current_channel.feeds
    end
  end
end

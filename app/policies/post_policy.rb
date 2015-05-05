class PostPolicy < ApplicationPolicy
  def index?
    record.channel.is_channel_publisher?(user)
  end

  def show?
    record.channel.is_channel_publisher?(user)
  end

  def create?
    record.channel.is_channel_publisher?(user)
  end

  def feedback?
    record.channel.has_user?(user)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

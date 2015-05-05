class ChannelPolicy < ApplicationPolicy
  def index?
    record.has_user?(user)
  end

  def show?
    record.has_user?(user)
  end

  def subscribe?
    true
  end

  def create?
    record.has_user?(user)
  end

  class Scope < Scope
    def resolve
      scope.where('channels.id IN (?) ', user.channels.pluck(:id))
    end
  end
end

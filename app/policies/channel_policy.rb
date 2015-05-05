class ChannelPolicy < ApplicationPolicy
  def index?
    true
  end

  def subscribe?
    true
  end

  class Scope < Scope
    def resolve
      scope.where('channels.id IN (?) ', user.channels.pluck(:id))
    end
  end
end

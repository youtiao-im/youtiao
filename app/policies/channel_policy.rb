class ChannelPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def subscribe?
    true
  end

  class Scope < Scope
    def resolve
      user.channels
    end
  end
end

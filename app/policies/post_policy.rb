class PostPolicy < ApplicationPolicy
  def index?
    # TODO
    true
  end

  def create?
    record.channel.publishers.exists?(id: user.id)
  end

  def feedback?
    show?
  end

  class Scope < Scope
    def resolve
      # TODO:
      scope.all
    end
  end
end

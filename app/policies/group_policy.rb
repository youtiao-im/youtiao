class GroupPolicy < ApplicationPolicy
  def show?
    # TODO: to model?
    Membership.where(group: record, user: user).exists?
  end

  def create?
    true
  end

  def admin?
    Membership.where(group: record, user: user, role: [:owner, :admin]).exists?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

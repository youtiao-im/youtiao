class GroupPolicy < ApplicationPolicy
  def show?
    record.memberships.exists?(user: user)
  end

  def admin?
    record.memberships.exists?(user: user, role: [:owner, :admin])
  end

  def not_admin?
    !admin?
  end
end

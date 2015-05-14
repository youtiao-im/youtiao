class ChannelPolicy < ApplicationPolicy
  def show?
    # TODO: to model?
    Membership.where(channel: record, user: user).exists?
  end

  def create?
    true
  end

  def admin?
    Membership.where(channel: record, user: user, role: [:owner, :admin]).exists?
  end
end

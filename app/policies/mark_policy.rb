class MarkPolicy < ApplicationPolicy
  def show?
    FeedPolicy.new(user, record.feed).show? &&
      (record.created_by == user || FeedPolicy.new(user, record.feed).admin?)
  end

  def create?
    FeedPolicy.new(user, record.feed).show? && record.created_by == user
  end

  def update?
    FeedPolicy.new(user, record.feed).show? && record.created_by == user
  end
end

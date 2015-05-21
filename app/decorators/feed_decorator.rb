class FeedDecorator < ApplicationDecorator
  decorates_association :channel
  decorates_association :created_by
  decorates_association :marks
  decorates_association :comments
  decorates_association :stars

  def mark
    object.mark_by(context[:current_user]).try(:decorate)
  end

  def star
    object.star_by(context[:current_user]).try(:decorate)
  end
end

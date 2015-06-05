class FeedDecorator < ApplicationDecorator
  delegate :text, :checks_count, :crosses_count, :comments_count
  decorates_association :channel
  decorates_association :created_by
  decorates_association :mark
end

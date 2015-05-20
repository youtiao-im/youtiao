class FeedDecorator < ApplicationDecorator
  decorates_association :channel
  decorates_association :created_by
  decorates_association :marks
  decorates_association :comments
  decorates_association :stars
end

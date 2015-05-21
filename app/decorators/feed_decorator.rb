class FeedDecorator < ApplicationDecorator
  decorates_association :channel
  decorates_association :created_by
  decorates_association :comments
  decorates_association :marks
  decorates_association :mark
  decorates_association :stars
  decorates_association :star
end

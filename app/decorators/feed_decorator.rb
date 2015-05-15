class FeedDecorator < ApplicationDecorator
  decorates_association :channel
  decorates_association :created_by
end

class MarkDecorator < ApplicationDecorator
  delegate :symbol
  decorates_association :feed
  decorates_association :user
end

class CommentDecorator < ApplicationDecorator
  delegate :text
  decorates_association :feed
  decorates_association :created_by
end

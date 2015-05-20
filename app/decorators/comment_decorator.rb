class CommentDecorator < ApplicationDecorator
  decorates_association :feed
  decorates_association :created_by
end

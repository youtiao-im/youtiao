class StarDecorator < ApplicationDecorator
  decorates_association :feed
  decorates_association :user
end

class ChannelDecorator < ApplicationDecorator
  decorates_association :created_by
  decorates_association :feeds
end

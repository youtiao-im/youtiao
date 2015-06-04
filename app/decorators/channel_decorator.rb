class ChannelDecorator < ApplicationDecorator
  delegate :name, :memberships_count
  decorates_association :created_by
  decorates_association :membership
end

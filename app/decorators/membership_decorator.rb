class MembershipDecorator < ApplicationDecorator
  delegate :role
  decorates_association :channel
  decorates_association :user
end

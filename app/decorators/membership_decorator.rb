class MembershipDecorator < ApplicationDecorator
  decorates_association :channel
  decorates_association :user
end

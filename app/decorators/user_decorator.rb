class UserDecorator < ApplicationDecorator
  decorates_association :memberships
  decorates_association :marks
  decorates_association :stars
end

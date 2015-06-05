class UserDecorator < ApplicationDecorator
  delegate :email
end

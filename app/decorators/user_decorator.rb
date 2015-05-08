class UserDecorator < ApplicationDecorator
  def id
    User.encrypt_id(object.id)
  end
end

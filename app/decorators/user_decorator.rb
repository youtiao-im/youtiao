class UserDecorator < ApplicationDecorator
  decorates_association :avatar

  def avatar_id
    object.avatar_id.nil? ? nil : Blob.encrypt_id(object.avatar_id)
  end
end

class MembershipDecorator < ApplicationDecorator
  decorates_association :group
  decorates_association :user

  def group_id
    Group.encrypt_id(object.group_id)
  end

  def user_id
    User.encrypt_id(object.user_id)
  end
end

class BulletinDecorator < ApplicationDecorator
  decorates_association :group
  decorates_association :created_by
  decorates_association :current_stamp

  def group_id
    Group.encrypt_id(object.group_id)
  end

  def created_by_id
    Membership.encrypt_id(object.created_by_id)
  end
end

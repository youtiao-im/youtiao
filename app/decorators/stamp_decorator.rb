class StampDecorator < ApplicationDecorator
  decorates_association :bulletin
  decorates_association :created_by

  def bulletin_id
    Bulletin.encrypt_id(object.bulletin_id)
  end

  def created_by_id
    Membership.encrypt_id(object.created_by_id)
  end
end

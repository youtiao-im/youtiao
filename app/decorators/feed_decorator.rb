class FeedDecorator < ApplicationDecorator
  def creator_id
    User.encrypt_id(object.creator_id)
  end

  def checked?
    stamp.nil? ? false : stamp.check?
  end

  def crossed?
    stamp.nil? ? false : stamp.cross?
  end

  def questioned?
    stamp.nil? ? false : stamp.question?
  end

  def checked_by_ids
    object.stamps.where(kind: :check).pluck(:user_id).map do |user_id|
      User.encrypt_id(user_id)
    end
  end

  def crossed_by_ids
    object.stamps.where(kind: :cross).pluck(:user_id).map do |user_id|
      User.encrypt_id(user_id)
    end
  end

  def questioned_by_ids
    object.stamps.where(kind: :question).pluck(:user_id).map do |user_id|
      User.encrypt_id(user_id)
    end
  end

  private

  def stamp
    @stamp ||= object.stamp(context[:current_user])
  end
end

class FeedDecorator < ApplicationDecorator
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
    object.stamps.where(kind: :check).pluck(:user_id)
  end

  def crossed_by_ids
    object.stamps.where(kind: :cross).pluck(:user_id)
  end

  def questioned_by_ids
    object.stamps.where(kind: :question).pluck(:user_id)
  end

  private

  def stamp
    @stamp ||= object.stamp(context[:current_user])
  end
end

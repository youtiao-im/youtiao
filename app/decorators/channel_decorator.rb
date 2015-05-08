class ChannelDecorator < ApplicationDecorator
  def creator_id
    User.encrypt_id(object.creator_id)
  end

  def owner?
    channel_user.nil? ? false : channel_user.owner?
  end

  def admin?
    channel_user.nil? ? false : channel_user.admin?
  end

  def owner_ids
    object.channel_users.where(role: :owner).pluck(:user_id).map do |user_id|
      User.encrypt_id(user_id)
    end
  end

  def admin_ids
    object.channel_users.where(role: :admin).pluck(:user_id).map do |user_id|
      User.encrypt_id(user_id)
    end
  end

  def member_ids
    object.channel_users.where(role: :member).pluck(:user_id).map do |user_id|
      User.encrypt_id(user_id)
    end
  end

  private

  def channel_user
    @channel_user ||= object.channel_user(context[:current_user])
  end
end

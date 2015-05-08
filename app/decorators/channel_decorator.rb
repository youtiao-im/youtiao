class ChannelDecorator < ApplicationDecorator
  def owner?
    channel_user.nil? ? false : channel_user.owner?
  end

  def admin?
    channel_user.nil? ? false : channel_user.admin?
  end

  def owner_ids
    object.channel_users.where(role: :owner).pluck(:user_id)
  end

  def admin_ids
    object.channel_users.where(role: :admin).pluck(:user_id)
  end

  def member_ids
    object.channel_users.where(role: :member).pluck(:user_id)
  end

  private

  def channel_user
    @channel_user ||= object.channel_user(context[:current_user])
  end
end

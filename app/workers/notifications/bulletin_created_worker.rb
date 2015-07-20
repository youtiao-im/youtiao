module Notifications
  class BulletinCreatedWorker < NotificationWorker
    def perform(bulletin_id)
      bulletin = Bulletin.find(bulletin_id)
      user_ids = bulletin.group.memberships.pluck(:user_id)
      alert_text = "#{bulletin.created_by.name}: #{bulletin.text}".truncate(48)
      encrypted_user_ids = user_ids.map { |user_id| User.encrypt_id(user_id) }
      send_push_notification(encrypted_user_ids, '+1', alert_text)
    end
  end
end

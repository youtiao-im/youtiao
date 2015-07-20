module Notifications
  class BulletinStampedWorker < NotificationWorker
    def perform(bulletin_id, user_id, symbol)
      bulletin = Bulletin.find(bulletin_id)
      user = User.find(user_id)
      alert_text = (I18n.t('notifications.bulletin_stamped') %
        { name: user.name, symbol: symbol }).truncate(48)
      encrypted_user_ids = [User.encrypt_id(bulletin.created_by_id)]
      send_push_notification(encrypted_user_ids, '+0', alert_text)
    end
  end
end

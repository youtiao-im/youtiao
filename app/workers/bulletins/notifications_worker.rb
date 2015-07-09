module Bulletins
  class NotificationsWorker
    include Sidekiq::Worker
    sidekiq_options retry: 0

    def notify_bulletin_created(bulletin_id)
      bulletin = Bulletin.find(bulletin_id)
      user_ids = bulletin.group.memberships.pluck(:user_id)
      alert_text = "#{bulletin.created_by.name}: #{bulletin.text}".truncate(48)
      encrypted_user_ids = user_ids.map { |user_id| User.encrypt_id(user_id) }

      master_secret = 'e417378d4d97db603089d50d'
      app_key = '0324f855f1b0b2a986b6ce57'
      client = JPush::JPushClient.new(app_key, master_secret)
      payload = JPush::PushPayload.new(
        platform: JPush::Platform.all,
        audience: JPush::Audience.new(_alias: encrypted_user_ids),
        notification: JPush::Notification.build(
          ios: JPush::IOSNotification.build(
            alert: alert_text,
            badge: '+1'),
          android: JPush::AndroidNotification.build(
            alert: alert_text)),
        options: JPush::Options.new)
      client.sendPush(payload)
    end

    def notify_bulletin_stamped(bulletin_id, user_id, symbol)
      bulletin = Bulletin.find(bulletin_id)
      user = User.find(user_id)
      alert_text = (I18n.t('notifications.bulletin_stamped') %
        { name: user.name, symbol: symbol }).truncate(48)

      master_secret = 'e417378d4d97db603089d50d'
      app_key = '0324f855f1b0b2a986b6ce57'
      client = JPush::JPushClient.new(app_key, master_secret)
      payload = JPush::PushPayload.new(
        platform: JPush::Platform.all,
        audience: JPush::Audience.new(_alias: [User.encrypt_id(bulletin.created_by_id)]),
        notification: JPush::Notification.build(
          ios: JPush::IOSNotification.build(
            alert: alert_text,
            badge: '+0'),
          android: JPush::AndroidNotification.build(
            alert: alert_text)),
        options: JPush::Options.new)
      client.sendPush(payload)
    end
  end
end

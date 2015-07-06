class BulletinStampedNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(bulletin_id, user_id, symbol)
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

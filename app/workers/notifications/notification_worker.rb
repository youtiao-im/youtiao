module Notifications
  class NotificationWorker
    include Sidekiq::Worker
    sidekiq_options retry: 0

    protected

    def send_push_notification(aliases, badge, text)
      app_key = "#{ENV['JPUSH_APP_KEY']}"
      master_secret = "#{ENV['JPUSH_MASTER_SECRET']}"
      client = JPush::JPushClient.new(app_key, master_secret)
      payload = JPush::PushPayload.new(
        platform: JPush::Platform.all,
        audience: JPush::Audience.new(_alias: aliases),
        notification: JPush::Notification.build(
          ios: JPush::IOSNotification.build(
            alert: text,
            badge: badge),
          android: JPush::AndroidNotification.build(
            alert: text)),
        options: JPush::Options.new)
      client.sendPush(payload)
    end
  end
end

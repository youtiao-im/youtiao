class NotificationJob
  include SuckerPunch::Job

  def perform(aliases, badge, text)
    return if Rails.env.test?
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
    begin
      client.sendPush(payload)
    rescue Exception
      # ignore
    end
  end
end

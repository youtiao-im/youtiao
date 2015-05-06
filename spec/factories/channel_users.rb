FactoryGirl.define do
  factory :channel_user do
    channel
    user
  end

  factory :channel_publisher, parent: :channel_user, class: ChannelUser do
    role :publisher
  end

  factory :channel_subscriber, parent: :channel_user, class: ChannelUser do
    role :subscriber
  end

  factory :channel_admin, parent: :channel_user, class: ChannelUser do
    role :admin
  end
end

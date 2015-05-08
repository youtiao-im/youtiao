# == Schema Information
#
# Table name: channel_users
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :channel_user do
    channel
    user
  end

  factory :channel_owner, parent: :channel_user, class: ChannelUser do
    role :owner
  end

  factory :channel_admin, parent: :channel_user, class: ChannelUser do
    role :admin
  end

  factory :channel_member, parent: :channel_user, class: ChannelUser do
    role :member
  end
end

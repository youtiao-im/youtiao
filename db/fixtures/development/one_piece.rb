User.seed_once(
  :id,
  { id: 1, email: 'luffy@straw-hat.org', password: '12345678' },
  { id: 2, email: 'zoro@straw-hat.org', password: '12345678' },
  { id: 3, email: 'nami@straw-hat.org', password: '12345678' },
  { id: 4, email: 'usopp@straw-hat.org', password: '12345678' },
  { id: 5, email: 'sanji@straw-hat.org', password: '12345678' },
  { id: 6, email: 'chopper@straw-hat.org', password: '12345678' },
  { id: 7, email: 'robin@straw-hat.org', password: '12345678' },
  { id: 8, email: 'franky@straw-hat.org', password: '12345678' },
  { id: 9, email: 'brook@straw-hat.org', password: '12345678' })

Channel.seed_once(
  :id,
  { id: 1, creator_id: 1, name: 'Going Merry' },
  { id: 2, creator_id: 1, name: 'Thousand Sunny' })

ChannelUser.seed_once(
  :id,
  { id: 1, channel_id: 1, user_id: 1, role: :owner },
  { id: 2, channel_id: 1, user_id: 2, role: :member },
  { id: 3, channel_id: 1, user_id: 3, role: :member },
  { id: 4, channel_id: 1, user_id: 4, role: :member },
  { id: 5, channel_id: 1, user_id: 5, role: :member },
  { id: 6, channel_id: 1, user_id: 6, role: :member },
  { id: 7, channel_id: 1, user_id: 7, role: :member },
  { id: 8, channel_id: 2, user_id: 1, role: :owner },
  { id: 9, channel_id: 2, user_id: 2, role: :member },
  { id: 10, channel_id: 2, user_id: 3, role: :member },
  { id: 11, channel_id: 2, user_id: 4, role: :member },
  { id: 12, channel_id: 2, user_id: 5, role: :member },
  { id: 13, channel_id: 2, user_id: 6, role: :member },
  { id: 14, channel_id: 2, user_id: 7, role: :member },
  { id: 15, channel_id: 2, user_id: 8, role: :member },
  { id: 16, channel_id: 2, user_id: 9, role: :member })

Feed.seed_once(
  :id,
  { id: 1, channel_id: 1, creator_id: 1, text: 'Advanture begins!' },
  { id: 2, channel_id: 1, creator_id: 1, text: 'Do we need a musician on board?' },
  { id: 3, channel_id: 2, creator_id: 2, text: '3D2Y' })

Stamp.seed_once(
  :id,
  { id: 1, feed_id: 1, user_id: 2, kind: :check },
  { id: 2, feed_id: 1, user_id: 3, kind: :check },
  { id: 3, feed_id: 1, user_id: 4, kind: :check },
  { id: 4, feed_id: 1, user_id: 5, kind: :check },
  { id: 5, feed_id: 2, user_id: 2, kind: :cross },
  { id: 6, feed_id: 2, user_id: 3, kind: :check },
  { id: 7, feed_id: 2, user_id: 4, kind: :question },
  { id: 8, feed_id: 2, user_id: 5, kind: :check },
  { id: 9, feed_id: 2, user_id: 6, kind: :question },
  { id: 10, feed_id: 2, user_id: 7, kind: :check },
  { id: 11, feed_id: 3, user_id: 2, kind: :check },
  { id: 12, feed_id: 3, user_id: 3, kind: :check },
  { id: 13, feed_id: 3, user_id: 4, kind: :check },
  { id: 14, feed_id: 3, user_id: 5, kind: :check },
  { id: 15, feed_id: 3, user_id: 6, kind: :check },
  { id: 16, feed_id: 3, user_id: 7, kind: :check },
  { id: 17, feed_id: 3, user_id: 8, kind: :check },
  { id: 18, feed_id: 3, user_id: 9, kind: :check })
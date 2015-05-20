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
  { id: 1, name: 'Going Merry', created_by_id: 1 },
  { id: 2, name: 'Thousand Sunny', created_by_id: 1 })

Membership.seed_once(
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
  { id: 1, channel_id: 1, text: 'Advanture begins!', created_by_id: 1 },
  { id: 2, channel_id: 1, text: 'Do we need a musician on board?', created_by_id: 1 },
  { id: 3, channel_id: 2, text: '3D2Y', created_by_id: 1 })

Mark.seed_once(
  :id,
  { id: 1, feed_id: 1, user_id: 2, symbol: :check },
  { id: 2, feed_id: 1, user_id: 3, symbol: :check },
  { id: 3, feed_id: 1, user_id: 4, symbol: :check },
  { id: 4, feed_id: 1, user_id: 5, symbol: :check },
  { id: 5, feed_id: 2, user_id: 2, symbol: :cross },
  { id: 6, feed_id: 2, user_id: 3, symbol: :check },
  { id: 7, feed_id: 2, user_id: 4, symbol: :question },
  { id: 8, feed_id: 2, user_id: 5, symbol: :check },
  { id: 9, feed_id: 2, user_id: 6, symbol: :question },
  { id: 10, feed_id: 2, user_id: 7, symbol: :check },
  { id: 11, feed_id: 3, user_id: 2, symbol: :check },
  { id: 12, feed_id: 3, user_id: 3, symbol: :check },
  { id: 13, feed_id: 3, user_id: 4, symbol: :check },
  { id: 14, feed_id: 3, user_id: 5, symbol: :check },
  { id: 15, feed_id: 3, user_id: 6, symbol: :check },
  { id: 16, feed_id: 3, user_id: 7, symbol: :check },
  { id: 17, feed_id: 3, user_id: 8, symbol: :check },
  { id: 18, feed_id: 3, user_id: 9, symbol: :check })

Comment.seed_once(
  :id,
  { id: 1, feed_id: 1, text: 'Hell yeah!', created_by_id: 2 },
  { id: 2, feed_id: 1, text: 'Need a map?', created_by_id: 4 },
  { id: 3, feed_id: 2, text: 'I have a candidate.', created_by_id: 5 })

Star.seed_once(
  :id,
  { id: 1, feed_id: 1, user_id: 2 },
  { id: 2, feed_id: 1, user_id: 3 },
  { id: 3, feed_id: 1, user_id: 4 },
  { id: 4, feed_id: 1, user_id: 5 },
  { id: 5, feed_id: 1, user_id: 6 },
  { id: 6, feed_id: 1, user_id: 7 },
  { id: 7, feed_id: 3, user_id: 2 },
  { id: 8, feed_id: 3, user_id: 3 },
  { id: 9, feed_id: 3, user_id: 4 },
  { id: 10, feed_id: 3, user_id: 5 },
  { id: 11, feed_id: 3, user_id: 6 },
  { id: 12, feed_id: 3, user_id: 7 },
  { id: 13, feed_id: 3, user_id: 8 },
  { id: 14, feed_id: 3, user_id: 9 })

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

Group.seed_once(
  :id,
  { id: 1, name: 'Going Merry' },
  { id: 2, name: 'Thousand Sunny' })

Membership.seed_once(
  :id,
  { id: 1, group_id: 1, user_id: 1, role: :owner },
  { id: 2, group_id: 1, user_id: 2, role: :member },
  { id: 3, group_id: 1, user_id: 3, role: :member },
  { id: 4, group_id: 1, user_id: 4, role: :member },
  { id: 5, group_id: 1, user_id: 5, role: :member },
  { id: 6, group_id: 1, user_id: 6, role: :member },
  { id: 7, group_id: 1, user_id: 7, role: :member },
  { id: 8, group_id: 2, user_id: 1, role: :owner },
  { id: 9, group_id: 2, user_id: 2, role: :member },
  { id: 10, group_id: 2, user_id: 3, role: :member },
  { id: 11, group_id: 2, user_id: 4, role: :member },
  { id: 12, group_id: 2, user_id: 5, role: :member },
  { id: 13, group_id: 2, user_id: 6, role: :member },
  { id: 14, group_id: 2, user_id: 7, role: :member },
  { id: 15, group_id: 2, user_id: 8, role: :member },
  { id: 16, group_id: 2, user_id: 9, role: :member })

Bulletin.seed_once(
  :id,
  { id: 1, group_id: 1, text: 'Advanture begins!', created_by_type: 'Membership',created_by_id: 1 },
  { id: 2, group_id: 1, text: 'Do we need a musician on board?', created_by_type: 'Membership',created_by_id: 1 },
  { id: 3, group_id: 2, text: '3D2Y', created_by_type: 'Membership',created_by_id: 8 })

Stamp.seed_once(
  :id,
  { id: 1, bulletin_id: 1, symbol: :check, created_by_type: 'Membership', created_by_id: 2 },
  { id: 2, bulletin_id: 1, symbol: :check, created_by_type: 'Membership',created_by_id: 3 },
  { id: 3, bulletin_id: 1, symbol: :check, created_by_type: 'Membership',created_by_id: 4 },
  { id: 4, bulletin_id: 1, symbol: :check, created_by_type: 'Membership',created_by_id: 5 },
  { id: 5, bulletin_id: 2, symbol: :cross, created_by_type: 'Membership',created_by_id: 2 },
  { id: 6, bulletin_id: 2, symbol: :check, created_by_type: 'Membership',created_by_id: 3 },
  { id: 7, bulletin_id: 2, symbol: :cross, created_by_type: 'Membership',created_by_id: 4 },
  { id: 8, bulletin_id: 2, symbol: :check, created_by_type: 'Membership',created_by_id: 5 },
  { id: 9, bulletin_id: 2, symbol: :cross, created_by_type: 'Membership',created_by_id: 6 },
  { id: 10, bulletin_id: 2, symbol: :check, created_by_type: 'Membership',created_by_id: 7 },
  { id: 11, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 9 },
  { id: 12, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 10 },
  { id: 13, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 11 },
  { id: 14, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 12 },
  { id: 15, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 13 },
  { id: 16, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 14 },
  { id: 17, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 15 },
  { id: 18, bulletin_id: 3, symbol: :check, created_by_type: 'Membership',created_by_id: 16 })

Comment.seed_once(
  :id,
  { id: 1, bulletin_id: 1, text: 'Hell yeah!', created_by_type: 'Membership',created_by_id: 2 },
  { id: 2, bulletin_id: 1, text: 'Need a map?', created_by_type: 'Membership',created_by_id: 4 },
  { id: 3, bulletin_id: 2, text: 'I have a candidate.', created_by_type: 'Membership',created_by_id: 12 })

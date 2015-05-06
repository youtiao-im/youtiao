json.array! posts do |post|
  json.call(post, :id, :channel_id, :content, :creator_id, :created_at, :updated_at)
end

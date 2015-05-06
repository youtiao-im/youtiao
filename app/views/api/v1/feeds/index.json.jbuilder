json.array! feeds do |feed|
  json.call(feed, :id, :channel_id, :content, :creator_id, :created_at, :updated_at)
end

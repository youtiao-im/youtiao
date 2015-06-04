json.call feed, :id, :text, :checks_count, :crosses_count, :questions_count,
          :comments_count, :created_at, :updated_at

json.channel do
  json.partial! 'api/v1/channels/channel', channel: feed.channel
end

unless feed.mark.nil?
  json.mark do
    json.call feed.mark, :symbol, :created_at, :updated_at
  end
end

unless feed.star.nil?
  json.star do
    json.call feed.star, :created_at, :updated_at
  end
end

json.created_by do
  json.partial! 'api/v1/users/user', user: feed.created_by
end

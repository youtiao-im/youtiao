json.partial! 'api/v1/models/feed', feed: feed

json.channel do
  json.partial! 'api/v1/models/channel', channel: feed.channel
end

json.created_by do
  json.partial! 'api/v1/models/user', user: feed.created_by
end

unless feed.mark.nil?
  json.mark do
    json.partial! 'api/v1/models/mark', mark: feed.mark
  end
end

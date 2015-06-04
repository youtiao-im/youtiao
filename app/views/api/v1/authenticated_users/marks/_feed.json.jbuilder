json.partial! 'api/v1/models/feed', feed: mark.feed

json.channel do
  json.partial! 'api/v1/models/channel', channel: mark.feed.channel
end

json.created_by do
  json.partial! 'api/v1/models/user', user: mark.feed.created_by
end

json.mark do
  json.partial! 'api/v1/models/mark', mark: mark
end

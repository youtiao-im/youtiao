json.partial! 'api/v1/shared/feed', feed: mark.feed

json.channel do
  json.partial! 'api/v1/shared/channel', channel: mark.feed.channel
end

json.created_by do
  json.partial! 'api/v1/shared/user', user: mark.feed.created_by
end

json.mark do
  json.partial! 'api/v1/shared/mark', mark: mark
end

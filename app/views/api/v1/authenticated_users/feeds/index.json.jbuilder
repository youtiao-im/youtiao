json.array! feeds do |feed|
  json.partial! 'api/v1/shared/feed', feed: feed

  json.channel do
    json.partial! 'api/v1/shared/channel', channel: feed.channel
  end

  json.created_by do
    json.partial! 'api/v1/shared/user', user: feed.created_by
  end

  unless feed.mark.nil?
    json.mark do
      json.partial! 'api/v1/shared/mark', mark: feed.mark
    end
  end
end

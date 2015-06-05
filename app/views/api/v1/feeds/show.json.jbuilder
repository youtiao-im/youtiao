json.partial! 'api/v1/shared/feed', feed: feed

json.created_by do
  json.partial! 'api/v1/shared/user', user: feed.created_by
end

unless feed.mark.nil?
  json.mark do
    json.partial! 'api/v1/shared/mark', mark: feed.mark
  end
end

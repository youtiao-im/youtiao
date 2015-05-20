json.call mark, :symbol, :created_at, :updated_at
json.feed do
  json.partial! 'api/v1/feeds/feed', feed: mark.feed
end

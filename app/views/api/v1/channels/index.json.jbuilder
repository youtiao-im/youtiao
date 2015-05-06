json.array! channels do |channel|
  json.call(channel, :id, :name, :created_at, :updated_at)
end

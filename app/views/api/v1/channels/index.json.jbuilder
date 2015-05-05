json.array! channels do |channel|
  json.(channel, :id, :name, :created_at, :updated_at)
end

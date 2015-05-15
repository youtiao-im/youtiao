json.(channel, :id, :name, :created_at, :updated_at)
json.created_by do
  json.partial! 'api/v1/users/user', user: channel.created_by
end

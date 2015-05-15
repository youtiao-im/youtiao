json.call(membership, :role, :created_at, :updated_at)
json.channel do
  json.partial! 'api/v1/channels/channel', channel: membership.channel
end

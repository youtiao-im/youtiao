json.partial! 'api/v1/models/channel', channel: channel

json.created_by do
  json.partial! 'api/v1/models/user', user: channel.created_by
end

json.membership do
  json.partial! 'api/v1/models/membership', membership: channel.membership
end

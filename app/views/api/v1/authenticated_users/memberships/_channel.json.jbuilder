json.partial! 'api/v1/models/channel', channel: membership.channel

json.created_by do
  json.partial! 'api/v1/models/user', user: membership.channel.created_by
end

json.membership do
  json.partial! 'api/v1/models/membership', membership: membership
end

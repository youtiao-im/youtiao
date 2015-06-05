json.partial! 'api/v1/shared/channel', channel: channel

json.created_by do
  json.partial! 'api/v1/shared/user', user: channel.created_by
end

json.membership do
  json.partial! 'api/v1/shared/membership', membership: channel.membership
end

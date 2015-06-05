json.partial! 'api/v1/shared/channel', channel: membership.channel

json.created_by do
  json.partial! 'api/v1/shared/user', user: membership.channel.created_by
end

json.membership do
  json.partial! 'api/v1/shared/membership', membership: membership
end

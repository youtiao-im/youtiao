json.partial! 'api/v1/models/membership', membership: membership

json.user do
  json.partial! 'api/v1/models/user', user: membership.user
end

json.partial! 'api/v1/shared/membership', membership: membership

json.user do
  json.partial! 'api/v1/shared/user', user: membership.user
end

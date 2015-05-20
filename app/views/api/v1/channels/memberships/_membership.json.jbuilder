json.call membership, :role, :created_at, :updated_at
json.user do
  json.partial! 'api/v1/users/user', user: membership.user
end

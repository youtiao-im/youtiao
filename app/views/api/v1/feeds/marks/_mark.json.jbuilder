json.partial! 'api/v1/models/mark', mark: mark

json.user do
  json.partial! 'api/v1/models/user', user: mark.user
end

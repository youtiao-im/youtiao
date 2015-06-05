json.array! marks do |mark|
  json.partial! 'api/v1/shared/mark', mark: mark

  json.user do
    json.partial! 'api/v1/shared/user', user: mark.user
  end
end

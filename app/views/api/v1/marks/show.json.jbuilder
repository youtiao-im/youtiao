json.partial! 'api/v1/shared/mark', mark: mark

json.created_by do
  json.partial! 'api/v1/shared/membership', membership: mark.created_by
end

json.partial! 'api/v1/shared/stamp', stamp: stamp

json.created_by do
  json.partial! 'api/v1/shared/user', user: stamp.created_by
end

json.array! stamps do |stamp|
  json.partial! 'api/v1/shared/stamp', stamp: stamp

  json.created_by do
    json.partial! 'api/v1/shared/membership', membership: stamp.created_by
  end
end

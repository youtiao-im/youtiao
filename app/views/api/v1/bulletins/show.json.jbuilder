json.partial! 'api/v1/shared/bulletin', bulletin: bulletin

json.group do
  json.partial! 'api/v1/shared/group', group: bulletin.group
end

json.created_by do
  json.partial! 'api/v1/shared/membership', membership: bulletin.created_by
end

unless bulletin.current_stamp.nil?
  json.stamp do
    json.partial! 'api/v1/shared/stamp', stamp: bulletin.current_stamp
  end
end

json.array! bulletins do |bulletin|
  json.partial! 'api/v1/shared/bulletin', bulletin: bulletin

  json.group do
    json.partial! 'api/v1/shared/group', group: bulletin.group
  end

  json.created_by do
    json.partial! 'api/v1/shared/user', user: bulletin.created_by
  end

  json.stamp do
    if bulletin.current_stamp.nil?
      json.null!
    else
      json.partial! 'api/v1/shared/stamp', stamp: bulletin.current_stamp
    end
  end
end

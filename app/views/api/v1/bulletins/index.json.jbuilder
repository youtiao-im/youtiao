json.array! bulletins do |bulletin|
  json.partial! 'api/v1/shared/bulletin', bulletin: bulletin

  json.group do
    json.partial! 'api/v1/shared/group', group: bulletin.group
  end

  json.created_by do
    json.partial! 'api/v1/shared/membership', membership: bulletin.created_by
  end

  unless bulletin.current_mark.nil?
    json.mark do
      json.partial! 'api/v1/shared/mark', mark: bulletin.current_mark
    end
  end
end

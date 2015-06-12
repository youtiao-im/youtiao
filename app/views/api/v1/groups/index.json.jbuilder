json.array! groups do |group|
  json.partial! 'api/v1/shared/group', group: group

  unless group.current_membership.nil?
    json.membership do
      json.partial! 'api/v1/shared/membership',
                    membership: group.current_membership
    end
  end
end

json.partial! 'api/v1/shared/group', group: group

json.membership do
  if group.current_membership.nil?
    json.null!
  else
    json.partial! 'api/v1/shared/membership',
                  membership: group.current_membership
  end
end

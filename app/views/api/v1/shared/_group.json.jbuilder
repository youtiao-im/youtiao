json.call group,
          :type,
          :id,
          :name,
          :memberships_count

json.created_at group.created_at.to_f.to_s
json.updated_at group.created_at.to_f.to_s

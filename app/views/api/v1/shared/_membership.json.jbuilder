json.call membership,
          :type,
          :id,
          :group_id,
          :user_id,
          :role

json.created_at membership.created_at.to_f.to_s
json.updated_at membership.updated_at.to_f.to_s

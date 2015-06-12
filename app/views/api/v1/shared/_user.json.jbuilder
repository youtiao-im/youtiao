json.call user,
          :type,
          :id,
          :email

json.created_at user.created_at.to_f.to_s
json.updated_at user.created_at.to_f.to_s

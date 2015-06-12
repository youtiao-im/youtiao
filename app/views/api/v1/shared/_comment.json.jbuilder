json.call comment,
          :type,
          :id,
          :bulletin_id,
          :text,
          :created_by_type,
          :created_by_id

json.created_at comment.created_at.to_f.to_s
json.updated_at comment.created_at.to_f.to_s

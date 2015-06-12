json.call stamp,
          :type,
          :id,
          :bulletin_id,
          :symbol,
          :created_by_type,
          :created_by_id

json.created_at stamp.created_at.to_f.to_s
json.updated_at stamp.created_at.to_f.to_s

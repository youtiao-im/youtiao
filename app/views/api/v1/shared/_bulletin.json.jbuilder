json.call bulletin,
          :type,
          :id,
          :group_id,
          :text,
          :created_by_id,
          :created_by_type,
          :checks_count,
          :crosses_count,
          :comments_count

json.created_at bulletin.created_at.to_f.to_s
json.updated_at bulletin.created_at.to_f.to_s

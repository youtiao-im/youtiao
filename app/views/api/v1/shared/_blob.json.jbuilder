json.call blob,
          :type,
          :id,
          :data_url

json.created_at blob.created_at.to_f.to_s
json.updated_at blob.updated_at.to_f.to_s

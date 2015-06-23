json.call user,
          :type,
          :id,
          :email,
          :name,
          :avatar_id

unless user.avatar.nil?
  json.avatar do
    json.partial! 'api/v1/shared/blob', blob: user.avatar
  end
end

json.created_at user.created_at.to_f.to_s
json.updated_at user.updated_at.to_f.to_s

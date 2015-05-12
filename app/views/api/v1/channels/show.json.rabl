object channel

attributes :id,
           :name,
           :created_at,
           :updated_at,
           :creator_id,
           :owner_ids,
           :admin_ids,
           :member_ids

attributes owner?: :is_owner,
           admin?: :is_admin,
           member?: :is_member

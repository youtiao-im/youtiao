module V1
  module Entities
    class BulletinEntity < BaseEntity
      expose :group_id, :created_by_id, :text, :checks_count, :crosses_count,
             :comments_count
      expose :group, using: BasicGroupEntity
      expose :created_by, using: UserEntity
      expose :current_stamp, using: BasicStampEntity
    end
  end
end

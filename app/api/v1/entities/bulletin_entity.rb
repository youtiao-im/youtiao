module V1
  module Entities
    class BulletinEntity < BaseEntity
      expose :text, :checks_count, :crosses_count, :comments_count
      expose :group_id do |bulletin|
        Group.encrypt_id(bulletin.group_id)
      end
      expose :created_by_id do |bulletin|
        User.encrypt_id(bulletin.created_by_id)
      end
      expose :group, using: BasicGroupEntity
      expose :created_by, using: UserEntity
      expose :current_stamp, using: BasicStampEntity
    end
  end
end

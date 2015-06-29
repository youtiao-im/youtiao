module V1
  module Entities
    class CommentEntity < BaseEntity
      expose :text
      expose :bulletin_id do |comment|
        Bulletin.encrypt_id(comment.bulletin_id)
      end
      expose :created_by_id do |comment|
        User.encrypt_id(comment.created_by_id)
      end
      expose :created_by, using: UserEntity
    end
  end
end

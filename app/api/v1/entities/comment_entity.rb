module V1
  module Entities
    class CommentEntity < BaseEntity
      expose :bulletin_id, :created_by_id, :text
      expose :created_by, using: UserEntity
    end
  end
end

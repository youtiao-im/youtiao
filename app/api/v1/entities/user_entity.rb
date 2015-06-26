module V1
  module Entities
    class UserEntity < BaseEntity
      expose :email, :name, :avatar_id
      expose :avatar, using: BlobEntity
    end
  end
end

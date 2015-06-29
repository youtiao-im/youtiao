module V1
  module Entities
    class UserEntity < BaseEntity
      expose :email, :name
      expose :avatar_id do |user|
        Blob.encrypt_id(user.avatar_id)
      end
      expose :avatar, using: BlobEntity
    end
  end
end

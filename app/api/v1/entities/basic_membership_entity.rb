module V1
  module Entities
    class BasicMembershipEntity < BaseEntity
      expose :role
      expose :group_id do |membership|
        Group.encrypt_id(membership.group_id)
      end
      expose :user_id do |membership|
        User.encrypt_id(membership.user_id)
      end
    end
  end
end

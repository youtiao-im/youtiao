module V1
  module Entities
    class BasicMembershipEntity < BaseEntity
      expose :group_id, :user_id, :role
    end
  end
end

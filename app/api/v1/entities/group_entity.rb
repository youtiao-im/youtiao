module V1
  module Entities
    class GroupEntity < BasicGroupEntity
      expose :current_membership, using: BasicMembershipEntity
    end
  end
end

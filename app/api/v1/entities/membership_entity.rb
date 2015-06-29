module V1
  module Entities
    class MembershipEntity < BasicMembershipEntity
      expose :user, using: UserEntity
    end
  end
end

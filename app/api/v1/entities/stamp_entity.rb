module V1
  module Entities
    class StampEntity < BasicStampEntity
      expose :created_by, using: UserEntity
    end
  end
end

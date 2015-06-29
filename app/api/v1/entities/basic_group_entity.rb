module V1
  module Entities
    class BasicGroupEntity < BaseEntity
      expose :name, :code, :memberships_count
    end
  end
end

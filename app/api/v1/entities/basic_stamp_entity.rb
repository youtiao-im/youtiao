module V1
  module Entities
    class BasicStampEntity < BaseEntity
      expose :symbol
      expose :bulletin_id do |stamp|
        Bulletin.encrypt_id(stamp.bulletin_id)
      end
      expose :created_by_id do |stamp|
        User.encrypt_id(stamp.created_by_id)
      end
    end
  end
end

module V1
  module Entities
    class BaseEntity < Grape::Entity
      expose :id do |record|
        record.to_param
      end

      expose :type do |record|
        record.class.name
      end

      expose :created_at do |record|
        record.created_at.to_f.to_s
      end

      expose :updated_at do |record|
        record.updated_at.to_f.to_s
      end
    end
  end
end

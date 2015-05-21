module Api
  module V1
    module AuthenticatedUsers
      module Memberships
        class Create < Mutations::Command
          required do
            integer :channel_id
            integer :user_id
            string :role
          end

          def execute
            Membership.create!(inputs)
          end
        end
      end
    end
  end
end

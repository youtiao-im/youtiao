module Api
  module V1
    module AuthenticatedUsers
      module Marks
        class Create < Mutations::Command
          required do
            integer :feed_id
            integer :user_id
            string :symbol
          end

          def execute
            Mark.create!(inputs)
          end
        end
      end
    end
  end
end

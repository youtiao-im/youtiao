module Api
  module V1
    module AuthenticatedUsers
      module Stars
        class Create < Mutations::Command
          required do
            integer :feed_id
            integer :user_id
          end

          def execute
            Star.create!(inputs)
          end
        end
      end
    end
  end
end

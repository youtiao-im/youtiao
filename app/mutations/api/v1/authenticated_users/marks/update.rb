module Api
  module V1
    module AuthenticatedUsers
      module Marks
        class Update < Mutations::Command
          required do
            model :mark
            string :symbol
          end

          def execute
            mark.update!(inputs.except(:mark))
            mark
          end
        end
      end
    end
  end
end

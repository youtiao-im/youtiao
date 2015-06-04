module Api
  module V1
    module AuthenticatedUsers
      module Marks
        class Set < Mutations::Command
          required do
            integer :feed_id
            integer :user_id
            string :symbol
          end

          def execute
            mark = Mark.pinpoint(feed_id, user_id)
            mark.update!(symbol: symbol)
            mark.feed.reload
            mark
          rescue ActiveRecord::RecordNotFound
            Mark.create!(inputs)
          end
        end
      end
    end
  end
end

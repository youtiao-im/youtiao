require 'text_formatter'

module Api
  module V1
    module Comments
      class Create < Mutations::Command
        required do
          integer :feed_id
          string :text
          integer :created_by_id
        end

        def execute
          self.text = TextFormatter.auto_link(text)
          Comment.create!(inputs)
        end
      end
    end
  end
end

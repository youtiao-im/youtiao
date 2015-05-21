require 'text_formatter'

module Api
  module V1
    module Feeds
      class Create < Mutations::Command
        required do
          integer :channel_id
          string :text
          integer :created_by_id
        end

        def execute
          self.text = TextFormatter.auto_link(text)
          Feed.create!(inputs)
        end
      end
    end
  end
end

module Api
  module V1
    module Channels
      class Create < Mutations::Command
        required do
          string :name
          integer :created_by_id
        end

        def execute
          channel = Channel.create!(inputs)
          Membership.create!(
            channel: channel, user_id: created_by_id, role: :owner)
          channel
        end
      end
    end
  end
end

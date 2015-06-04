module Api
  module V1
    module AuthenticatedUsers
      class FeedsController < ApiController
        decorates_assigned :feeds

        def index
          @feeds = paginate current_resource_owner.feeds.includes(
            :channel, :mark, :star, :created_by, channel: :created_by)
        end
      end
    end
  end
end

require 'text_formatter'

module Api
  module V1
    class CommentsController < ApiController
      before_action :set_feed, only: [:index, :create]
      before_action :set_comment, except: [:index, :create]

      decorates_assigned :comments
      decorates_assigned :comment

      def index
        authorize @feed.channel, :show?
        @comments = paginate @feed.comments
      end

      def show
        authorize @comment.feed.channel, :show?
      end

      def create
        authorize @feed.channel, :show?
        @comment = Comment.new(safe_create_params)
        @comment.feed = @feed
        @comment.created_by = current_resource_owner
        @comment = Comments::Create.run!(@comment.attributes)
        render :show
      end

      private

      def set_feed
        @feed = Feed.find(params[:feed_id])
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def safe_create_params
        params.permit(:text)
      end
    end
  end
end

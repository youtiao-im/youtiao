module Api
  module V1
    class PostsController < ApiController
      before_action :set_channel

      decorates_assigned :posts
      decorates_assigned :post

      def index
        begin
          @posts = policy_scope(@channel.posts)
          authorize @channel
        rescue NotAuthorizedError
          render status: :forbidden
        end
      end

      def show
        begin
          @post = Post.find(params[:id])
          authorize @channel
        rescue NotAuthorizedError
          render status: :forbidden
        end
      end

      def create
        begin
          authorize @channel
          @post = Post.new(safe_create_params)
          @post.channel = @channel
          @post.creator = current_resource_owner
          @post.save!
          authorize @post
          render :show
        rescue NotAuthorizedError
          puts 'not authorized error'
          render status: :forbidden
        rescue ActiveRecord::StatementInvalid
          render status: :bad_request
        rescue ActiveRecord::RecordNotUnique
          render status: :conflict
        end
      end

      def feedback
        begin
          @post = Post.find(params[:id])
          authorize @post

          if params[:sticker].nil?
            render status: :bad_request
          else
            begin
              Feedback.create(post: @post, creator: current_resource_owner, sticker: params[:sticker])
            rescue ActiveRecord::RecordNotUnique
              feedback = Feedback.find_by(post: @post, creator: current_resource_owner)
              feedback.sticker = params[:sticker]
              feedback.save
            end
          end
        rescue NotAuthorizedError
          render status: :forbidden
        rescue ActiveRecord::RecordNotUnique
          render status: :conflict
        end
      end

      private
      def set_channel
        begin
          @channel = Channel.find(params[:channel_id])
        rescue ActiveRecord::RecordNotFound
          @channel = nil
          render status: :not_found
        end
      end

      def safe_create_params
        params.permit(:content)
      end
    end
  end
end

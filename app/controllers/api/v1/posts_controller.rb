module Api
  module V1
    class PostsController < ApiController
      before_action :set_channel, only: [:index, :create]
      before_action :set_post, except: [:index, :create]

      decorates_assigned :posts
      decorates_assigned :post

      def index
        @posts = policy_scope(Post)
      end

      def show
        @post = Post.find(params[:id])
        authorize @post
      end

      def create
        @post = Post.new(safe_create_params)
        @post.channel = @channel
        @post.creator = current_resource_owner
        authorize @post
        @post.save!
        render :show
      end

      def feedback
        authorize @post

        if params[:sticker].nil?
          render status: :bad_request, nothing: true
          return
        end

        begin
          Feedback.create(post: @post, creator: current_resource_owner,
            sticker: params[:sticker])
        rescue ActiveRecord::RecordNotUnique
          feedback = Feedback.find_by(post: @post, creator: current_resource_owner)
          feedback.sticker = params[:sticker]
          feedback.save
        end

        render nothing: true
      end

      private

      def set_channel
        @channel = Channel.find(params[:channel_id])
      end

      def set_post
        @post = Post.find(params[:id])
      end

      def safe_create_params
        params.permit(:content)
      end
    end
  end
end

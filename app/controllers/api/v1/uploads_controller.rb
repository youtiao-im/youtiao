module Api
  module V1
    class UploadsController < ApiController
      def create
        put_policy = Qiniu::Auth::PutPolicy.new('maiyatang')
        put_policy.callback_url = commit_api_v1_uploads_url
        put_policy.callback_body = 'key=$(key)'
        data = { up_token: Qiniu::Auth.generate_uptoken(put_policy) }
        render json: data, status: :ok
      end

      def commit
        data = { url: "http://maiyatang.qiniudn.com/#{params[:key]}" }
        render json: data, status: :ok
      end
    end
  end
end

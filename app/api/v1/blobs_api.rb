module V1
  class BlobsAPI < Grape::API
    post 'blobs.token' do
      put_policy = Qiniu::Auth::PutPolicy.new('maiyatang')
      # TODO: put_policy.callback_url = api_v1_blobs_url
      put_policy.callback_url = 'http://new.meepotech.com:3000/api/v1/blobs.create'
      put_policy.callback_body = 'data_url=http://maiyatang.qiniudn.com/$(key)'
      data = { upload_token: Qiniu::Auth.generate_uptoken(put_policy) }
      render json: data, status: :ok
    end

    params do
      requires :data_url, type: String
    end
    post 'blobs.create' do
      safe_params = ActionController::Parameters.new(params).permit(
        :data_url)
      blob = Blob.new(safe_params)
      blob.save!
      present blob, using: Entities::BlobEntity
    end
  end
end

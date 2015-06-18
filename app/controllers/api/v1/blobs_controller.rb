class Api::V1::BlobsController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!

  decorates_assigned :blob

  def token
    # TODO: change bucket
    put_policy = Qiniu::Auth::PutPolicy.new('maiyatang')
    # TODO: put_policy.callback_url = api_v1_blobs_url
    put_policy.callback_url = 'http://new.meepotech.com:3000/api/v1/blobs'
    put_policy.callback_body = 'data_url=http://maiyatang.qiniudn.com/$(key)'
    data = { upload_token: Qiniu::Auth.generate_uptoken(put_policy) }
    render json: data, status: :ok
  end

  def create
    @blob = Blob.new(safe_create_params)
    # @blob.created_by = current_resource_owner
    @blob.save!
    render :show
  end

  private

  def safe_create_params
    params.permit(:data_url)
  end
end

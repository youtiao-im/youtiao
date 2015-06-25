class Api::V1::ApiController < ActionController::Base
  include Pundit

  rescue_from ActionController::ParameterMissing,
              ActiveRecord::RecordInvalid,
              ActionController::BadRequest do
    render nothing: true, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound,
              Hashids::InputError do
    render nothing: true, status: :not_found
  end

  rescue_from Pundit::NotAuthorizedError do
    render nothing: true, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotUnique do
    render nothing: true, status: :conflict
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError do
      render nothing: true, status: :not_found
    end

    rescue_from Exception do
      render nothing: true, status: :internal_server_error
    end
  end

  before_action :doorkeeper_authorize!
  before_action :set_format_json
  before_action :set_current_user

  def current_resource_owner
    @current_resource_owner ||=
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def pundit_user
    current_resource_owner
  end

  def limit(scope)
    limit = 25
    unless params[:limit].nil?
      limit = params[:limit].to_i
      limit = limit > 500 ? 500 : limit
    end
    scope.limit(limit)
  end

  private

  def set_format_json
    request.format = :json
  end

  def set_current_user
    User.current = current_resource_owner
  end
end

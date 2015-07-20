module V1
  class API < Grape::API
    version :v1, using: :path
    format :json
    use WineBouncer::OAuth2

    before do
      User.current = resource_owner
    end

    before do
      status 200
    end

    helpers Pundit
    helpers do
      def current_user
        User.current
      end
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!({ error: :bad_request, message: e.message }, 400)
    end

    rescue_from WineBouncer::Errors::OAuthUnauthorizedError,
                WineBouncer::Errors::OAuthForbiddenError do
      error!({ error: :not_authenticated }, 401)
    end

    rescue_from Pundit::NotAuthorizedError do
      error!({ error: :not_authorized }, 403)
    end

    rescue_from ActiveRecord::RecordNotFound do
      error!({ error: :not_found }, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error = nil
      e.record.errors.each do |attribute, message|
        if message.match(/\A.*(has already been taken).*\z/)
          error = "#{attribute}:taken"
        elsif message.match(/\A.*(too long).*\z/)
          error = "#{attribute}:too_long"
        elsif message.match(/\A.*(too short).*\z/)
          error = "#{attribute}:too_short"
        elsif message.match(/\A.*(can't be blank).*\z/)
          error = "#{attribute}:blank"
        else
          error = "#{attribute}:invalid"
        end
        break
      end
      error!({ error: error }, 422)
    end

    rescue_from Exception do
      error!({ error: :internal_server_error }, 500)
    end

    mount V1::UsersAPI
    mount V1::GroupsAPI
    mount V1::MembershipsAPI
    mount V1::BulletinsAPI
    mount V1::StampsAPI
    mount V1::CommentsAPI
  end
end

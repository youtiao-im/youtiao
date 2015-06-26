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
      error_response(message: { error: :bad_request,
                                message: e.message },
                     status: 400)
    end

    rescue_from WineBouncer::Errors::OAuthUnauthorizedError,
                WineBouncer::Errors::OAuthForbiddenError do
      error_response(message: { error: :not_authenticated },
                     status: 401)
    end

    rescue_from Pundit::NotAuthorizedError do
      error_response(message: { error: :not_authorized },
                     status: 403)
    end

    rescue_from ActiveRecord::RecordNotFound do
      error_response(message: { error: :not_found },
                     status: 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error = nil
      e.record.errors.each do |field, message|
        if message.match(/\A.*(has already been taken).*\z/)
          error = "#{field}_taken"
        elsif message.match(/\A.*(too long).*\z/)
          error = "#{field}_too_long"
        elsif message.match(/\A.*(too short).*\z/)
          error = "#{field}_too_short"
        elsif message.match(/\A.*(can't be blank).*\z/)
          error = "#{field}_blank"
        else
          error = "#{field}_invalid"
        end
        break
      end
      error_response(message: { error: error },
                     status: 422)
    end

    mount V1::UsersAPI
    mount V1::GroupsAPI
    mount V1::MembershipsAPI
    mount V1::BulletinsAPI
    mount V1::StampsAPI
    mount V1::CommentsAPI
  end
end

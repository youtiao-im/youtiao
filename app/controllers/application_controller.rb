class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include HttpAcceptLanguage::AutoLocale

  def new_user_session_path
    ap 'good'
    root_path
  end

  def new_session_path(resource_name)
    ap resource
    root_path
  end
end

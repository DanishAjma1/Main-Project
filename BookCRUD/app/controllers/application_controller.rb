class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!

  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    root_path # Redirect to the dashboard after sign-in
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirect to the homepage after sign-out
  end
end

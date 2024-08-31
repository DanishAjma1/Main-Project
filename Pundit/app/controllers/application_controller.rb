class ApplicationController < ActionController::Base
  include Pundit
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # rubocop:disable Layout/EmptyLinesAroundClassBody

  protect_from_forgery with: :exception, prepend: true
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to root_path
  end

  before_action :authenticate_user!

  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    root_path # Redirect to the dashboard after sign-in
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirect to the homepage after sign-out
  end
end

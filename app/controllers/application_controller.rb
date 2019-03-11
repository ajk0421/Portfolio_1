class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :login_required

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def login_required
    redirect_to new_user_session_path, alert: "ログインして下さい" unless current_user
  end
end

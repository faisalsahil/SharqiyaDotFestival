class ApplicationController < ActionController::Base
  
  helper_method :include_controller_js?, :include_controller_css?

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user_role

  def include_controller_js?
    @include_controller_js
  end

  def include_controller_js
    @include_controller_js = true
  end

  def include_controller_css
    @include_controller_css = true
  end

  def include_controller_css?
      @include_controller_css
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit({ roles: [] }, :email, :password, :password_confirmation)
    end
  end

  def set_current_user_role
    @current_user_role = current_user.roles.last.name if user_signed_in?
  end
end
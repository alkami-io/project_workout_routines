class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  #
  ## Take Admin to the dashboard after successful login
  def after_sign_in_path_for(resource_or_scope)
    admin_path(current_admin)
  end

  #
  ## Return Admin to Home screen after Successfully logging out
  def after_sign_out_path(resource_or_scope)
    root_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :starting_weight, :current_weight, :height, :age])
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Devise::Controllers::StoreLocation
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # include Pundit::Authorization

  # Pundit: allow-list approach
  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  protected

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end


  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  # def skip_pundit?
  #   devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  # end

end

# make sure to add PUNDIT action on your CRUD actions if you have any concern

# REMEMBER WITH PUNDIT
# please use readme.md file or the lecture
# https://kitt.lewagon.com/camps/1290/lectures/05-Rails%2F10-Airbnb-Ajax-in-Rails

class ApplicationController < ActionController::Base

  include ApplicationHelper

  #before_action :authenticate_user!

  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :name, :surname, :email, :password, :country, :city, :street, :postcode)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :name, :surname, :email, :password, :current_password, :country, :city, :street, :postcode)}
  end

end

class ApplicationController < ActionController::Base
  before_action :devise_parameter_sanitizer, if: :devise_controller?

  private
  def authenticate!
    if [current_user, current_catering].all? { |i| i.nil? }
      authenticate_user!
    end
  end

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    elsif resource_class == Catering
      Catering::ParameterSanitizer.new(Catering, :catering, params)
    else
      super
    end
  end

end
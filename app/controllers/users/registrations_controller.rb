class Users::RegistrationsController < Devise::RegistrationsController
  before_action :add_sanitized_params

  def add_sanitized_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:gets_daily_dharma])
  end
end

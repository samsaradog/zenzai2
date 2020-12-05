class Users::RegistrationsController < Devise::RegistrationsController
  before_action :add_sanitized_params

  def create
    flash.delete :recaptcha_error

    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add(:base, t(:recaptcha_error))
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
    end
  end

  def add_sanitized_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:gets_daily_dharma])
  end
end

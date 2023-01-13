# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    if verify_recaptcha(action: 'sign_in', minimum_score: ENV['RECAPTCHA_THRESHOLD'].to_f, secret_key: ENV['RECAPTCHA_V3_SECRET_KEY'])
      super
    else
      self.resource = resource_class.new(sign_in_params)
      flash.now[:notice] = t(:recaptcha_error)
      respond_with_navigational(resource) { render :new }
    end
  end
end

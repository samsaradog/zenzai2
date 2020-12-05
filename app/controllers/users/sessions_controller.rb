# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
     if verify_recaptcha
       super
     else
       self.resource = resource_class.new(sign_in_params)
       flash.now[:notice] = t(:recaptcha_error)
       respond_with_navigational(resource) { render :new }
     end
  end
end

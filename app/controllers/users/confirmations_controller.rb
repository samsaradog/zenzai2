# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  def create
     if verify_recaptcha
       super
     else
       self.resource = resource_class.new
       flash.now[:notice] = t(:recaptcha_error)
       respond_with_navigational(resource) { render :new }
     end
  end
end

class SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, :only => [:create]

  include SimpleCaptcha::ControllerHelpers

  def create
    if simple_captcha_valid?
      super
    else
      flash[:alert] = "Captcha code is wrong, try again."
      self.resource = resource_class.new(sign_in_params)
      respond_with_navigational(resource) { render :new }
    end
  end
end

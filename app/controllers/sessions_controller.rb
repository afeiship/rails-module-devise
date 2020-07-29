class SessionsController < Devise::SessionsController
  include SimpleCaptcha::ControllerHelpers
  # prepend_before_action :require_no_authentication, :only => [:create]

  def create
    puts params
    if simple_captcha_valid?
      puts "valided??"
      super
    else
      flash[:alert] = "Captcha code is wrong, try again."
      self.resource = resource_class.new(sign_in_params)
      respond_with_navigational(resource) { render :new }
    end
  end
end

# customize registration controller
class RegistrationsController < Devise::RegistrationsController

  # def new
  #   redirect_to :omniauth_callbacks
  # end

  protected
  def sign_up_params
    session_user = session["devise.user_attributes"]
    session_user.merge(super) if session_user
  end
end

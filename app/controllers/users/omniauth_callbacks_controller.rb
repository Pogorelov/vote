class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    omniauth_action
  end

  def facebook
    omniauth_action
  end

  private
    def omniauth_action
      @user = Identity.find_for_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
      end
    end
end

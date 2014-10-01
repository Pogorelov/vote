class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    omniauth_action
  end

  def facebook
    omniauth_action
  end

  def twitter
    identity = Identity.find_by provider: request.env['omniauth.auth']['provider'], uid: request.env['omniauth.auth']['uid']
    if @user = identity.try(:user)
      sign_in_and_redirect @user, event: :authentication
    else
      request.env['omniauth.auth']['extra'] = nil
      session['auth'] = request.env['omniauth.auth']
      redirect_to finish_signup_users_url
    end
  end

  private
    def omniauth_action
      @user = User.find_or_create_for_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
      end
    end
end

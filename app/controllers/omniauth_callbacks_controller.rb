class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    callback_from :line
  end

  private

    def callback_from(provider)
      provider = provider.to_s

      @user = User.from_omniauth(request.env['omniauth.auth'])


      if @user.persisted?
        set_flash_message(:notice, :success, kind: provider.capitalize)
        sign_in_and_redirect @user, event: :authentication
      else
        puts @user.errors
        set_flash_message(:alert, :failure, kind: provider.capitalize, reason: @user.errors.full_messages.join(', '))
        redirect_to login_path
      end
    end

    def after_sign_in_path_for(_resource)
      session[:after_sign_in_path_for_user] || root_path
    end
end
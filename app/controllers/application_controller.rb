class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def current_user
    User.find_by(id: session['warden.user.user.key'])
  end
end

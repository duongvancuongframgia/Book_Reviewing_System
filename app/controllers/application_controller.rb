class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "app.controllers.application.logged_in_user"
      redirect_to login_url
    end
  end
end

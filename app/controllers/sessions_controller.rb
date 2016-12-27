class SessionsController < ApplicationController
  def new
  end

  def create
<<<<<<< HEAD
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.remember_me ?
        remember(user) : forget(user)
      redirect_back_or user
=======
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Your account has been banned. "
        message += "Contact with admin for more information."
        flash[:warning] = message
        redirect_to root_url
      end
>>>>>>> 7837ce8... Finish admin
    else
      flash.now[:danger] = t "app.controllers.session.login_error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

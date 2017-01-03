class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, except: :destroy
  before_action :load_request, only: :destroy


  def new
    @request = Request.new
  end

  def create
    @request = @user.requests.build request_params
    unless @request.save
      flash[:warning] = t "app.controllers.request.error_save"
      redirect_to root_path
    end
    flash[:success] = t "app.controllers.request.success_save"
    redirect_to user_path @user
  end

  def destroy
    @request.destroy
    flash[:success] = t "app.controllers.request.success_delete"
    redirect_back fallback_location: :back
  end

  private
  def load_user
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "app.not_exits"
      redirect_to root_path
    end
  end

  def load_request
    @request = Request.find_by id: params[:id]
    unless @request
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end

  def request_params
    params.require(:request).permit :book_title, :content
  end
end

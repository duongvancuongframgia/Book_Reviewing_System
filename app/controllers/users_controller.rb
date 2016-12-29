class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :load_user, except: [:new, :create]

  def index
    @users = User.all
  end

  def new
    if logged_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def show
    @reviews = @user.reviews.paginate page: params[:page]
    @books = @user.favouriting.paginate page: params[:page]
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:info] = t "app.controllers.user.create_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "app.controllers.user.update_success"
      redirect_to @user
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "app.not_exits"
      redirect_to root_path
    end
  end
end

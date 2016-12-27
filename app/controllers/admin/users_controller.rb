class Admin::UsersController < ApplicationController
  before_action :verify_admin_access?

  def index
    @users = User.all.paginate(page: params[:page],
      per_page: Settings.per_page)
  end

  def new
    if logged_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user
      flash[:warning] = t "error_not_exits"
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:info] = "Account successfully!"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.activated?
      @user.update(activated: false)
      flash[:success] = "#{@user.name} was Banned"
      redirect_to admin_users_path
    else
      @user.update(activated: true)
      flash[:success] = "#{@user.name} was UnBanned"
      redirect_to admin_users_path
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = t "admin.success_destroyed_user"
    redirect_to [:admin, :users]
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def user_params_act
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation, :activated )
  end
end

class FollowersController < ApplicationController
  before_action :logged_in_user
  before_action :load_user

  def index
    @title = t "app.controllers.followers.title_follower"
    @users = @user.followers.paginate page: params[:page]
  end

  private
  def load_user
    @user = User.find_by id: params[:user_id]
    unless @user
      redirect_to root_path
    end
  end
end

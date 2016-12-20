class FollowersController < ApplicationController
  before_action :logged_in_user

  def index
    @title = t "title_followers"
    @user = User.find_by(id: params[:user_id])
    unless @user
      redirect_to root_path
    end
    @users = @user.followers.paginate(page: params[:page])
    respond_to do |format|
      format.js {render "users/show_follow.js.erb", object: @users}
    end
  end
end

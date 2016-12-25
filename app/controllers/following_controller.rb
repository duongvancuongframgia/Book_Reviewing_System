class FollowingController < ApplicationController
  before_action :logged_in_user

  def index
    @title = t "app.controllers.following.title_following"
    @user = User.find_by id: params[:user_id]
    unless @user
      redirect_to root_path
    end
    @users = @user.following.paginate page: params[:page]
    # respond_to do |format|
    #   format.js {render "users/show_follow_list.js.erb", object: @users}
    # end
  end
end

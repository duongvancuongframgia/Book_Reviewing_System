class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user

  def create
    current_user.follow @user
    send_respond @user
  end

  def destroy
    current_user.unfollow @user
    send_respond @user
  end

  private
  def load_user
    @user = User.find_by id: params[:relationship][:id]
    unless @user
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end

  def send_respond object
    respond_to do |format|
      format.json do
        render json: {followers: object.followers.size,
          following: object.following.size}
      end
    end
  end
end

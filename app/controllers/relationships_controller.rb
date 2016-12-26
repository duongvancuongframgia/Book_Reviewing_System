class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:relationship][:id]
    unless @user
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
    relationship = current_user.follow @user
    respond_to do |format|
      format.json do
        render json: {status: "OK"}
      end
    end
  end

  def destroy
    relationship = Relationship.find_by_follower_id_and_followed_id current_user.id,
      params[:relationship][:id]
    unless relationship
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
    # current_user.unfollow @user
    # respond_to do |format|
    #   format.json do
    #     render json: {user_id: @user.id}
    #   end
    # end
    @user = User.find_by id: params[:relationship][:id]
    current_user.unfollow @user
    # relationship.destroy
    respond_to do |format|
      format.json do
        render json: {status: "OK"}
      end
    end
  end
end

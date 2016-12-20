class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @activity = Activity.find_by(id: params[:activity_id])
    current_user.like(@activity)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @activity = Like.find_by(id: params[:id]).activity
    current_user.unlike(@activity)
    respond_to do |format|
      format.js
    end
  end
end

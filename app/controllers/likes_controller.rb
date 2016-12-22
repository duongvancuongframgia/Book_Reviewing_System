class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @activity = Activity.find_by(object_id: params[:object_id], action_type: params[:action_type])
    @review = Review.find_by(id: params[:object_id])
    current_user.like(@activity)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @activity = Like.find_by(id: params[:id]).activity
    @review = Review.find_by(id: @activity.object_id)
    current_user.unlike(@activity)
    respond_to do |format|
      format.js
    end
  end
end

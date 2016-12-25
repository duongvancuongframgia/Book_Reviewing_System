class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :load_review, only: [:create]
  before_action :load_activity, only: [:create]

  def create
    current_user.like @activity
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @activity = Like.find_by(id: params[:id]).activity
    @review = Review.find_by id: @activity.object_id
    current_user.unlike @activity
    respond_to do |format|
      format.js
    end
  end

  private
    def load_review
      @review = Review.find_by id: params[:object_id]
      unless @review
        flash[:warning] = t "app.not_exits"
        redirect_to root_url
      end
    end

    def load_activity
      @activity = Activity.find_by object_id: params[:object_id],
        action_type: params[:action_type]
      unless @activity
        flash[:warning] = t "app.not_exits"
        redirect_to root_url
      end
    end
end

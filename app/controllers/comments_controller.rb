class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_review
  before_action :load_book
  before_action :load_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new comment_params
    if @comment.save
      current_user.activities.create object_id: @comment.id,
        Settings.action_type_comment
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else 
      render :edit
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content).merge user_id: current_user.id,
        review_id: params[:review_id]
    end

    def load_book
    @book = @review.book
    unless @book
      flash[:danger] = t "app.not_exits"
      redirect_to books_path
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "app.not_exits"
      redirect_to book_path
    end
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
    unless @review
      flash[:danger] = t "app.not_exits"
      redirect_to book_path
    end
  end
end

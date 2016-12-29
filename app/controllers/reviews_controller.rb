class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :load_review, only: [:edit, :update, :destroy]
  before_action :load_book, only: :create
  before_action :load_user, only: :index

  def index
    @reviews = @user.reviews.includes(:user, :book, comments: :user)
      .paginate page: params[:page], per_page: Settings.per_page
    respond_to do |format|
      format.js {render "users/show_review.js.erb", object: @reviews}
    end
  end

  def create
    @review = @book.reviews.build review_params
    unless @review.save
      flash[:warning] = t "app.controllers.reviews.error_create"
      redirect_to root_path
    end
    redirect_back fallback_location: :back
  end

  def edit
    respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
  end

  def update
    if @comment.update_attributes review_params
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to @review.user
  end

  private
  def review_params
    params.require(:review).permit(:title, :content)
      .merge! user_id: current_user.id
  end

  def load_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to books_url
    end
  end

  def load_user
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:warning] = t "app.not_exits"
      redirect_to root_path
    end
  end
end

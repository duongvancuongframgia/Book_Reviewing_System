class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :load_review, only: [:edit, :update, :destroy]
  before_action :load_book, only: [:create, :edit]
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
    @prev = Rails.application.routes.recognize_path(request.referrer)
    respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "app.controllers.reviews.edit_ok"
      redirect_back fallback_location: :back
    else
      flash[:warning] = t "app.controllers.reviews.edit_error"
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_back fallback_location: :back
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

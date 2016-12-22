class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]

  def index
    @user = User.find_by(id: params[:user_id])
    unless @user
      redirect_to root_path
    end
    @reviews = @user.reviews.includes(:user, :book, comments: :user)
      .paginate(page: params[:page], per_page: Settings.per_page)
    respond_to do |format|
      format.js {render "users/show_review.js.erb", object: @reviews}
    end
  end

  def create
    @book = Book.find_by(id: params[:book_id])
    unless @book
      flash[:warning] = t "record_isnt_exist"
      redirect_to books_url
    end
    @review = @book.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      current_user.activities.create(object_id: @review.id, action_type: 1)
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @review = Review.find_by(id: params[:id])
    respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
  end

  def update
    @review = Review.find_by(id: params[:id])
    if @comment.update_attributes(review_params)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else 
      render :edit
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])
    if @review
      @review.destroy
      redirect_to @review.user
    else
      redirect_to root_path
    end
  end

  private
    def review_params
      params.require(:review).permit(:title, :content)
    end
end

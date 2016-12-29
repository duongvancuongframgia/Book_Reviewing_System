class BooksController < ApplicationController
  before_action :logged_in_user, except: [:show, :index]
  before_action :load_book, only: :show

  def index
    @books = Book.filter_newest.paginate page: params[:page],
      per_page: Settings.per_page
    unless params[:search].blank?
      @books = Book.search_by_title(params[:search]).filter_newest
        .paginate page:params[:page], per_page: Settings.per_page
    end
    # @books = Book.search_by_title(params[:search]).filter_newest
    # if params[:category].blank?
    #   @books = Book.filter_newest.paginate page: params[:page],
    #     per_page: Settings.per_page
    # else
    #   @category = Category.find_by id: params[:category]
    #   unless @category
    #     flash[:danger] = t "record_isnt_exist"
    #     redirect_to books_path
    #   else
    #     @books = @category.books.filter_newest.paginate page: params[:page],
    #       per_page: Settings.per_page
    #   end
    # end
  end

  def show
    if logged_in?
      @review = @book.reviews.build
      @rate = @book.raters.build
    end
    # @books_relate = @book.category.books.get_books_except_current_book(@book.id)
    #   .newest
    @reviews = @book.reviews.includes(:user, comments: :user).newest
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end
end

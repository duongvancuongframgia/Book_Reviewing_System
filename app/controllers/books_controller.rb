class BooksController < ApplicationController
  before_action :logged_in_user, except: [:show, :index]
  
  def index
     @books = Book.filter_newest.paginate(page: params[:page],
        per_page: Settings.per_page)
   end

  def index_search
    @books_search_by_title = Book.search_by_title.paginate(page: params[:page])
      .newest
    if params[:category].blank?
      @books = Book.newest.paginate(page: params[:page],
        per_page: Settings.per_page)
    else
      @category = Category.find_by(id: params[:category])
      unless @category
        flash[:danger] = t "error_not_exits"
        redirect_to books_path
      else
        @books = @category.books.newest.paginate(page: params[:page],
          per_page: Settings.per_page)
      end
    end
  end

  def show
    @book = Book.find(params[:id])
    unless @book
      flash[:warning] = t "error_not_exits"
      redirect_to root_url
    end
    if logged_in?
      @review = @book.reviews.build
      @rate = @book.raters.build
    end
    # @books_relate = @book.category.books.get_books_except_current_book(@book.id)
    #   .newest
    @reviews = @book.reviews.includes(:user, comments: :user).newest
      .paginate(page: params[:page], per_page: Settings.per_page)
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
end

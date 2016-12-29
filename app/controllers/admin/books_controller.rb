class Admin::BooksController < ApplicationController
  before_action :verify_admin_access?
  before_action :load_book, except: [:create, :new, :index]
  
  def index
    @books = Book.filter_newest.paginate page: params[:page],
      per_page: Settings.per_page
  end
  
  def show
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "admin.created_book"
      redirect_to [:admin, :books]
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @book.update book_params
      redirect_to [:admin, :books]
    else
      render :edit
    end
  end
  
  def destroy
    if @book.destroy
      flash[:success] = t "admin.success_destroyed_book"
    else
	    flash[:success] = t "admin.unsuccess_destroyed_book"
	  end
    redirect_to [:admin, :books]
  end
  
  private
  def book_params
    params.require(:book).permit :title, :description, :publish_date, :author, :image,
      :page, :rating, :category_id
  end
  
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book
	    flash[:warning] = t "error_not_exits"
	    redirect_to root_url
    end
  end
end

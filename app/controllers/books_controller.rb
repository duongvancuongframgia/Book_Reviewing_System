class BooksController < ApplicationController
	before_action :logged_in_user
  before_action :correct_user

  def index
  	@books = Book.paginate(page: params[:page])
  end

  def show
    @book = Book.find(params[:id])
  end
end

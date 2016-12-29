class BookmarksController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, only: [:create, :update]

  def create
    current_user.like @activity
    respond_to do |format|
      format.js
    end
  end

  private
  def load_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end
end

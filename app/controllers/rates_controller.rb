class RatesController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, only: :create
  before_action :load_book_rating, only: :update

  def create
    current_user.rate @book, params[:num_rate]
    redirect_to book_path @book
  end

  def update
    current_user.re_rate @book, params[:num_rate]
    redirect_to book_path @book
  end

  private
  def load_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end

  def load_book_rating
    @book = Rating.find_by(id: params[:id]).book
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end
end

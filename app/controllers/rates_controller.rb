class RatesController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
    current_user.rate @book, params[:num_rate]
    # respond_to do |format|
    #   format.js
    # end
    redirect_to book_path @book
  end

  def update
    @book = Rating.find_by(id: params[:id]).book
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
    current_user.re_rate @book, params[:num_rate]
    # respond_to do |format|
    #   format.js
    # end
    redirect_to book_path @book
  end
end

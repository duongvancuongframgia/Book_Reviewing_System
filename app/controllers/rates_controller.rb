class RatesController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find_by id: params[:book_id]
    current_user.rate(@book, params[:num_rate])
    respond_to do |format|
      format.js
    end
  end

  def update
    @book = Rating.find_by(id: params[:id]).book
    current_user.re_rate(@book, params[:rate][:num_rate])
    respond_to do |format|
      format.js
    end
  end
end

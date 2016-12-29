class FavouritesController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find_by id: params[:favourite][:book_id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
    current_user.favourite @book
    respond_to do |format|
      format.json do
        render json: {status: "OK",favourite: "btn btn-circle", value: "unfavourite"}
      end
    end
  end

  def destroy
    @book = Book.find_by id: params[:favourite][:book_id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
    current_user.unfavourite @book
    respond_to do |format|
      format.json do
        render json: {status: "OK",favourite: "btn btn-danger btn-circle", value: "favourite"}
      end
    end
  end
end

class FavouritesController < ApplicationController
  before_action :logged_in_user
  before_action :load_book

  def create
    current_user.favourite @book
    send_respond "unfavourite"
  end

  def destroy
    current_user.unfavourite @book
    send_respond "favourite"
  end

  private
  def load_book
    @book = Book.find_by id: params[:favourite][:book_id]
    unless @book
      flash[:warning] = t "app.not_exits"
      redirect_to root_url
    end
  end

  def send_respond value
    respond_to do |format|
      format.json do
        render json: {value: value}
      end
    end
  end
end

class ReadingsController < ApplicationController
  before_action :logged_in_user
  before_action :load_book

  def create
    current_user.read @book
    send_respond "read"
  end

  def destroy
    current_user.unread @book
    send_respond "reading"
  end

  private
  def load_book
    @book = Book.find_by id: params[:reading][:book_id]
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

class StaticPagesController < ApplicationController
  def home
    @books_more_rate = Book.more_rate
    @books_newest = Book.show_newest
  end

  def help
  end

  def about
  end

  def contact
  end
end
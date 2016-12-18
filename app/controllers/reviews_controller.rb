class ReviewsController < ApplicationController

	def index
		@user = User.find_by(id: params[:user_id])
		unless @user
			redirect_to root_path
		end
		@reviews = @user.reviews.includes(:user, :book, comments:[:user]).paginate(page: params[:page], per_page: 5)
		respond_to do |format|
      format.js {render "users/show_review.js.erb", object: @reviews}
    end
	end

	def create
		@review = @book.reviews.build(review_params)
		@review.user_id = current_user.id
		@review.save
		respond_to do |format|
      format.js
    end
	end

	private
		def review_params
			params.require(:review).permit(:title, :content)
		end
end

class Admin::UsersController < ApplicationController
	before_action :verify_admin_access?
	before_action :load_users, except: [:index]
	
	def index
		@users = User.all_except(current_user).paginate page: params[:page],
			per_page: Settings.per_page
	end
	
	def show
		@reviews = @user.reviews
	end
	
	def edit
	end
	
	def update
		if @user.activated?
			@user.update activated: false
			flash[:success] = "#{@user.name} " + t("admin.user_ban")
			redirect_to admin_users_path
		else
			@user.update activated: true
			flash[:success] = "#{@user.name} " + t("admin.user_unban")
			redirect_to admin_users_path
		end
	end
	
	def destroy
		if @user.destroy
			flash[:success] = t "admin.success_destroyed_user"
		else
			flash[:success] = t "admin.unsuccess_destroyed_user"
		end
		redirect_to admin_users_path
	end
	
	private
	def review_params
		params.require(:review).permit :title, :content
	end
	
	def load_users
		@user = User.find_by id: params[:id]
		unless @user
			flash[:warning] = t "error_not_exits"
			redirect_to root_url
		end
	end
end

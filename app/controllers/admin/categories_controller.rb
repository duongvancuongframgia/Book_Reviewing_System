class Admin::CategoriesController < ApplicationController
	before_action :verify_admin_access?
	before_action :load_category, except: [:create, :index, :new]
	
	def index
		@categories = Category.all.paginate page: params[:page],
			per_page: Settings.per_page
	end
	
	def show
	end
	
	def new
		@category = Category.new
	end
	
	def create
		@category = Category.new category_params
		if @category.save
			flash[:success] = t "admin.created_category"
			redirect_to [:admin, :categories]
		else
			render :new
		end
	end
	
	def edit
	end
	
	def update
		if @category.update_attributes category_params
			flash[:success] = t "admin.updated_category"
			redirect_to [:admin, :categories]
		else
			render :edit
		end
	end
	
	def destroy
		if @category.destroy
			flash[:success] = t "admin.success_destroyed_category"
		else
			flash[:success] = t "admin.unsuccess_destroyed_category"
		end
		redirect_to [:admin, :categories]
	end
	
	private
	def category_params
		params.require(:category).permit :name
	end
	
	def load_category
		@category = Category.find_by id: params[:id]
		unless @category
			flash[:warning] = t "error_not_exits"
			redirect_to root_url
		end
	end
end

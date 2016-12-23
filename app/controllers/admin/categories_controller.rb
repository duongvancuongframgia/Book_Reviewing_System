class Admin::CategoriesController < ApplicationController
  before_action :verify_admin_access?

  def index
    @categories = Category.all.paginate(page: params[:page],
                                         per_page: Settings.per_page)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin_book"
      redirect_to [:admin, :categories]
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to [:admin, :categories]
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = t "admin.success_destroyed_category"
    redirect_to [:admin, :categories]
  end

  private

  def category_params
    params.require(:category).permit :name
  end
end

class Admin::RequestsController < ApplicationController
  before_action :verify_admin_access?
  
  def index
    @requests = Request.all.paginate page: params[:page],
      per_page: Settings.per_page
  end
  
  def edit
    @request = Request.new
  end

  def update
    @request = Request.find_by id: params[:id]
    @request.status = params[:status]
    if @request.save
      redirect_to :back
    else
      render :edit
    end
  end
end

class Admin::StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

def index
  @stores = Store.all

  @stores = @stores.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
  @stores = @stores.where("LOWER(email) LIKE ?", "%#{params[:email].downcase}%") if params[:email].present?
  @stores = @stores.where("LOWER(address) LIKE ?", "%#{params[:address].downcase}%") if params[:address].present?

  if params[:sort].present?
    direction = params[:sort] == "asc" ? 1 : -1
    @stores = @stores.sort_by(&:average_rating)
    @stores.reverse! if direction == -1
  end
end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)

    if @store.save
      redirect_to admin_stores_path, notice: "Store created successfully."
    else
      flash.now[:alert] = "Failed to create store."
      render :new
    end
  end

  private

  def ensure_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end

  def store_params
    params.require(:store).permit(:name, :email, :address, :user_id)
  end
end

class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user

  def index
    @stores = Store.includes(:ratings)

    if params[:name].present?
      @stores = @stores.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
    end

    if params[:address].present?
      @stores = @stores.where("LOWER(address) LIKE ?", "%#{params[:address].downcase}%")
    end
  end


  private

  def ensure_normal_user
    redirect_to root_path, alert: "Access denied" unless current_user.normal_user?
  end
end

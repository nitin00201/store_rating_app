class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role
    when "admin"
      # Admin dashboard summary
      @total_users = User.count
      @total_stores = Store.count
      @total_ratings = Rating.count

    when "store_owner"
      @store = current_user.stores.first
      if @store
        @ratings = @store.ratings.includes(:user)
        @average_rating = @store.average_rating
        @total_ratings = @ratings.size
      else
        flash[:alert] = "No store assigned to your account yet."
      end

    when "normal_user"
      @stores = Store.includes(:ratings)
      @stores = @stores.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
      @stores = @stores.where("address ILIKE ?", "%#{params[:address]}%") if params[:address].present?
      @user_ratings = current_user.ratings.index_by(&:store_id)
    end
  end
end

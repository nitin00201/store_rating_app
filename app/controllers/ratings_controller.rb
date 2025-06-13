class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @rating = Rating.find_or_initialize_by(user_id: current_user.id, store_id: params[:store_id])
    @rating.value = params[:value]

    if @rating.save
      redirect_back fallback_location: stores_path, notice: "Rating saved."
    else
      redirect_back fallback_location: stores_path, alert: @rating.errors.full_messages.to_sentence
    end
  end

  def clear
    rating = Rating.find_by(user_id: current_user.id, store_id: params[:store_id])
    if rating
      rating.destroy
      flash[:notice] = "Rating cleared."
    else
      flash[:alert] = "No rating found to clear."
    end
    redirect_back fallback_location: stores_path
  end
end

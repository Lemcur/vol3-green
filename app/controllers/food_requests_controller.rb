class FoodRequestsController < ApplicationController
  def create
    current_user.food_requests.where(
      "created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now
    ).each do |i|
      i.destroy
    end

    @f = FoodRequest.new(user_id: current_user.id, daily_meal_id: params[:daily_meal_id])
    if @f.save
      flash[:notice] ="Food ordered!"
    else
      flash[:alert] = "Failed to order"
    end
    redirect_to catering_path(params[:watched_catering])
  end

  private
  def food_request_params
    params.require(:food_request).permit(:daily_meal_id, :watched_catering)
  end
end
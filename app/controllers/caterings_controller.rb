class CateringsController < ApplicationController
  before_action :authenticate!
	def index
    @caterings = Catering.all
	end

	def show
		begin @catering = Catering.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			record_not_found()
		end
    @daily_meals_today = DailyMeal.where(catering: @catering, serving_day: Date.today).all
    @user_current_order = FoodRequest.where(user: current_user)
    								 .where("created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now)
  end

  private

	def record_not_found
		redirect_to root_path
		flash[:alert] = "No such catering"
	end

end

class DailyMealsController < ApplicationController
  before_action :authenticate_catering!

  def index
    @daily_meals = DailyMeal.where(catering: current_catering, serving_day: Date.today)
    @catering = current_catering
  end

  def new
    @daily_meal = DailyMeal.new
    @meals = Meal.where(catering: current_catering)
  end

  def create
    @selected_meal_ids = daily_meals_params[:meal].reject { |e| e.empty? }

    begin
      @selected_meal_ids.each do |sm_id|
      @new_daily_meal = current_catering.daily_meals.build(
        serving_day: Date.today,
        meal_id: sm_id
      )
      @new_daily_meal.save
    end
    rescue ActiveRecord::RecordNotSaved => e
      flash[:alert] = "Daily meal saving failed."
    else
      flash[:notice] = "Daily meal successfully created."
    end

    redirect_to catering_daily_meals_path
  end

  private
  def daily_meals_params
    params.require(:daily_meal).permit(meal: [])
  end
end

class MealsController < ApplicationController

  before_action :authenticate_catering!

  def index
    # The catering service can list all the meals they offer
    @meals = Meal.where(catering: current_catering)

    @diets = Diet.all
    @catering = current_catering
  end

  def show
    # The catering service can display a specific meal
    # with some stats maybe?
    # Times ordered, last ordered, ...
    @meal = Meal.find(params.require(:id))

    @diets = @meal.diets.pluck(:name).map(&:downcase).join(", ")

    @ingredients = @meal.ingredients.pluck(:name).join(", ")
    @order_count = DailyMeal.where(meal: @meal).map { |dm| dm.food_requests.count }.reduce(:+)
    @todays_order_count = DailyMeal.where(meal: @meal, serving_day: Date.today).map do |dm|
      dm.food_requests.count 
    end.reduce(:+)
  end

  def new
    @meal = Meal.new
  end

  def create

    @meal = current_catering.meals.build(
      name: meal_params[:name]
    )

    meal_params[:ingredients].reject { |e| e.empty? }.each do |i_id|
      @meal.ingredients << Ingredient.find(i_id.to_i)
    end

    meal_params[:diets].reject { |e| e.empty? }.each do |d_id|
      @meal.diets << Diet.find(d_id.to_i)
    end

    if @meal.save
      flash[:notice] = "Meal successfully created!"
      redirect_to new_catering_meal_path
    else
      flash[:alert] = "Something failed."
      render :new
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, ingredients: [], diets: [])
  end
  
end

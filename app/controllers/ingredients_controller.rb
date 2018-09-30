class IngredientsController < ApplicationController
  before_action :authenticate_catering!

  def index
    @ingredients = Ingredient.all
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      flash[:notice] = "Ingredient added successfully!"
    else
      flash[:alert] = "Ingredient not saved!"
    end
    redirect_to ingredients_path

  end

  def new
    @ingredient = Ingredient.new
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def new_allergic_prefs
    @user = current_user
  end
  
  def create_allergic_prefs
      if current_user.update(user_params)
        flash[:notice] = "You have created your preferences successfully!"
        redirect_to users_edit_allergic_prefs_path
      else
        redirect_to users_new_allergic_prefs_path
        flash[:alert] = "Preferences not saved!"
      end
  end

  def edit_allergic_prefs
    @user = current_user
  end

  def delete_allergic_prefs
    if current_user.allergies.delete(allergy_params[:id])
      flash[:notice] = "Ingredient removed successfully!"
      redirect_to users_edit_allergic_prefs_path
    else
      redirect_to users_edit_allergic_prefs_path
      flash[:alert] = "Not removed. Something went wrong!"
    end
  end

  def edit_diet
    @diet = current_user.diets.first
  end

  def update_diet
    current_diet = current_user.diets.first.name
    @diet = params[:diets]
    if @diet == nil
      @diet = current_diet
    end
    current_user.diets.clear()
    if current_user.diets << Diet.find_by_name(@diet)
      flash[:notice] = "Your diet is now #{@diet}"
    else
      flash[:alert] = "Something went wrong! :C"
    end
    redirect_to users_edit_diet_path
  end

  def dashboard
    @user = current_user
    @current_food_request = @user.food_requests.
        where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now).first
    @user_historic_food_requests = @user.food_requests.
        where('created_at  < ? ', DateTime.now.beginning_of_day)
  end

  private

  def allergy_params
    params.require(:ingredient).permit(:id)
  end

  def user_params
    params.require(:user).permit(allergy_ids: [])
  end

end
class OrderMealForUsersJob < ApplicationJob
  queue_as :order_meal
  attr_accessor :catering, :autorequested_orders
  after_perform do |job|
    puts "Job finished for #{job.catering.name} <##{job.catering.email}>.Autorequested orders: #{job.autorequested_orders}."

    if Catering.exists?(id: job.catering.id)
      food_order_hour = job.catering.get_food_order_close_time[:hour]
      food_order_minute = job.catering.get_food_order_close_time[:min]
      job_date = DateTime.now.tomorrow.change({hour: food_order_hour, min: food_order_minute})
      OrderMealForUsersJob.set(wait_until: job_date).perform_later(job.catering.id)
    end
  end

  def perform(catering_id)
    unless Catering.exists?(id: catering_id)
      puts "Catering with id #{catering_id} does not exist! quitting job..."
      return false
    end
    puts 'Started performing job!'
    @catering = Catering.find_by(id: catering_id)
    @autorequested_orders = 0
    puts 'Users: '
    puts @catering.users
    users_without_order.each do |user|
      puts 'ordering meal for user: '
      puts user
      non_allergic_meals = today_daily_meals.reject{ |dm| dm.is_allergic?(user.allergies) }
      puts 'Non allergic meals: '
      puts non_allergic_meals
      preferred_meals = non_allergic_meals.select { |meal| meal.diet == user.diets.first}
      puts 'Preferred meals: '
      puts preferred_meals
      if preferred_meals.nil?
        preferred_meals = @catering.daily_meals
      end
      ordered_meal = preferred_meals.sample
      puts 'Ordered meal: '
      puts ordered_meal
      FoodRequest.create(is_autorequested: true, user: user, daily_meal: ordered_meal)
      @autorequested_orders += 1
    end
  end

  def today_daily_meals
    @catering.daily_meals.where('serving_day = ?', Date.today)
  end

  def users_without_order
    result = @catering.users.reject(&:has_ordered_food_today?)
  end
end

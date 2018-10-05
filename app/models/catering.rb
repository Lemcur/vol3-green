class Catering < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meals
  has_many :daily_meals
  has_and_belongs_to_many :users,
                          foreign_key: 'catering_id',
                          join_table: :subscriptions
  validates_presence_of :name
  validates_presence_of :city
  
  after_create do |catering|
    queue_food_order_job(catering.id)
  end

  after_update do |catering|
    queue_food_order_job(catering.id)
  end

  def get_food_order_close_time
    time = self.food_order_close_time.split(':')
      {hour: time[0].to_i, min: time[1].to_i}
  end

  def queue_food_order_job (catering_id)
    close_min = get_food_order_close_time[:min]
    close_hour = get_food_order_close_time[:hour]

    if DateTime.now.hour > close_hour and DateTime.now.min > close_min
      job_date = DateTime.now.tomorrow.change({hour: close_hour, min: close_min, sec: 0 })
    else
      job_date = DateTime.now.change({hour: close_hour, min: close_min, sec: 0 })
    end

    OrderMealForUsersJob.set(wait_until: job_date).perform_later(catering_id)
  end

end

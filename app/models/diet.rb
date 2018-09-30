class Diet < ApplicationRecord
  has_and_belongs_to_many :users,
                          foreign_key: 'diet_id',
                          join_table: :users_diets
  has_and_belongs_to_many :meals,
                          foreign_key: 'diet_id',
                          join_table: :meals_diets
end

class Ingredient < ApplicationRecord
  has_and_belongs_to_many :allergic_users,
                          class_name: 'User' ,
                          foreign_key: 'ingredient_id',
                          join_table: :users_allergies
  has_and_belongs_to_many :meals,
                          class_name: 'Meal' ,
                          foreign_key: 'ingredient_id',
                          join_table: :meals_ingredients
  validates :name,
    presence: true,
    uniqueness: true,
    allow_blank: false,
    format: { with: /\A[a-z A-Z]+\z/, message: 'only allows letters' }
end

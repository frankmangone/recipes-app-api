class Recipe < ApplicationRecord
  has_many :steps
  has_many :recipe_ingredients
end
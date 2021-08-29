class Recipe < ApplicationRecord
  has_many :steps
  has_many :recipe_ingredients

  accepts_nested_attributes_for :steps
  accepts_nested_attributes_for :recipe_ingredients
end
class Recipe < ApplicationRecord
  has_many :steps
  has_many :recipe_ingredients

  accepts_nested_attributes_for :steps
  accepts_nested_attributes_for :recipe_ingredients

  def self.populate
    { 
      include: { 
        steps: {
          except: :recipe_id,
        },
        recipe_ingredients: { 
          include: { 
            unit: {}, 
            ingredient: {} 
          },
          except: [:ingredient_id, :recipe_id, :unit_id],
        }
      }
    }
  end
end
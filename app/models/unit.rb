class Unit < ApplicationRecord
  # Unit is an admin-maintained model
  # The records are seeded through $ bin/rake units_seed
  has_many :recipe_ingredients
end

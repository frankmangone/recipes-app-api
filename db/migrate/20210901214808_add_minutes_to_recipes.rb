class AddMinutesToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :minutes, :integer
  end
end

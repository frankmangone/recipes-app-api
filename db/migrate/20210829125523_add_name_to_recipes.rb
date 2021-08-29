class AddNameToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :name, :string
  end
end

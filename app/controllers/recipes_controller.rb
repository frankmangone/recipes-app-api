class RecipesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  # After hours of searching, this is the way to render :json
  # when having nested associations:
  # https://stackoverflow.com/questions/6755080/how-to-include-nested-and-sibling-associations-in-active-record-to-json

  def index
    recipes = Recipe.all
    render status: :ok, json: recipes
  end

  def show
    # Eager loading is used to reduce the number of queries, since the list
    # of recipe_ingredients can be long, and we don't want to be querying unit
    # and ingredient for each recipe_ingredient
    recipe = Recipe.includes(recipe_ingredients: [:unit, :ingredient]).find(params[:id])
    render status: :ok, json: recipe.to_json(Recipe.populate)
  end

  def create
    recipe = Recipe.new(recipe_params)

    if recipe.invalid?
      render status: :unprocessable_entity
    elsif recipe.save
      render status: :ok, json: recipe
    else
      render status: :internal_server_error
    end
  end
  
  private

    # Resources on permitting nested arrays of objects:
    # https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-permit
    # https://www.reddit.com/r/rubyonrails/comments/l2o4rn/how_to_permit_an_array_json_with_rails/
    def recipe_params
      params.require(:recipe).permit(
        :name,
        :minutes,
        { steps_attributes: [:description] },
        { recipe_ingredients_attributes: [:amount, :ingredient_id, :unit_id] }
      )
    end
  
end

class RecipesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    recipes = Recipe.all
    render json: recipes
  end

  def show
    recipe = Recipe.find(params[:id])
    render status: :ok, json: recipe
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

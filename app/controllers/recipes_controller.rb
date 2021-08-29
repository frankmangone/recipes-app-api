class RecipesController < ApplicationController

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

  def recipe_params
    params.require(:recipe).permit(:name)
  end
  
end

class IngredientsController < ApplicationController

  def index
    ingredients = Ingredient.all
    render json: ingredients
  end

  def show
    ingredient = Ingredient.find(params[:id])
    render status: :ok, json: ingredient
  end

  def create
    ingredient = Ingredient.new(ingredient_params)

    if ingredient.invalid?
      render status: :unprocessable_entity
    elsif ingredient.save
      render status: :ok, json: ingredient
    else
      render status: :internal_server_error
    end
  end
  
  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end

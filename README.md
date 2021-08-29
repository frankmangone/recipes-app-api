# For development

After cloning, run:
>
> $ rails db:create
> $ rails db:migrate
> $ bin/rails units_seed
>

# Endpoints
 All paths relative to base url (http://localhost:3000)

## Ingredients

- *GET* /ingredients
Gets a list of all ingredients in DB. Should limit and add search capabilities, pagination, etc.

- *GET* /ingredients/:id
Gets a particular ingredient information

- *POST* /ingredients
Adds a new ingredient. Payload should be of the form:
{
  name: `string`
}

## Recipes

- *GET* /recipes
Gets a list of all recipes in DB. Should limit and add search capabilities, pagination, etc.

- *GET* /recipes/:id
Gets a particular recipe information

- *POST* /recipes
Adds a new recipe. Payload should be of the form:
{
  name: `string`
  steps_attributes: [
    { description: `string` }
  ]
  recipe_ingredients_attributes: [
    { 
      amount: `number`,
      unit_id: `number`,
      ingredient_id: `number`,
    }
  ]
}

Example: 
>
> curl -X POST http://localhost:3000/recipes -H "Content-Type: application/json" -d '{"name": "Lentil burgers", "steps_attributes": [{ "description": "A test description" }, { "description": "Another test" }], "recipe_ingredients_attributes": [{ "ingredient_id": 1, "unit_id": 1 }, { "ingredient_id": 2, "unit_id": 2 }] }'
>


- (...) More soon
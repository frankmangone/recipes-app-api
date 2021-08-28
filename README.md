## For development

After cloning, run:
>
> $ rails db:create
> $ rails db:migrate
> $ bin/rails units_seed
>

## Endpoints

# Ingredients
 All paths relative to base url (http://localhost:3000)

- *GET* /ingredients
Gets a list of all ingredients in DB. Should limit and add search capabilities, pagination, etc.

- *GET* /ingredients/:id
Gets a particular ingredient information

- *POST* /ingredients
Adds a new ingredient. Payload should be of the form:
{
  name: string
}

- (...) More soon
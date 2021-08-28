task units_seed: :environment do
  # Run task with:
  # $ bin/rake units_seed

  Unit.delete_all
  units        = Unit.create(name: 'units', short_name: '-')
  
  # Mass
  grams        = Unit.create(name: 'grams', short_name: 'g')
  kilograms    = Unit.create(name: 'kilograms', short_name: 'kg')
  pounds       = Unit.create(name: 'pounds', short_name: 'lb')  
  
  # Volume
  cups         = Unit.create(name: 'cups', short_name: 'c')
  pinch        = Unit.create(name: 'pinch', short_name: 'pch')
  table_spoons = Unit.create(name: 'table_spoons', short_name: 'tbsp')
  tea_spoons   = Unit.create(name: 'tea_spoons', short_name: 'tsp')
  liters       = Unit.create(name: 'liters', short_name: 'L')
  milliliters  = Unit.create(name: 'milliliters', short_name: 'mL')

  # Temperature
  celsius      = Unit.create(name: 'celsius', short_name: 'ºC')
  fahrenheit   = Unit.create(name: 'fahrenheit', short_name: 'ºF')
end

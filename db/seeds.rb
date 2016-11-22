# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




Dietlabel.create([

{name: 'Balanced', apiparameter: 'balanced', description: 'Protein/Fat/Carb values in 15/35/50 ratio'},

{name: 'High-Fiber', apiparameter: 'high-fiber', description: 'More than 5g fiber per serving'},
{name: 'High-Protein', apiparameter: 'high-protein', description: 'More than 50% of total calories from proteins'},
{name: 'Low-Carb', apiparameter: 'low-carb', description: 'Less than 20% of total calories from carbs'},
{name: 'Low-Fat', apiparameter: 'low-fat', description: 'Less than 15% of total calories from fat'},
{name: 'Low-Sodium', apiparameter: 'low-sodium', description: 'Less than 140mg Na per serving'} ])


Healthlabel.create([

#{name: 'Alcohol', apiparameter: 'alcohol-free', description: 'No alcohol used or contained in the recipe'},
{name: 'Alcohol-free', apiparameter: 'alcohol-free', description: 'No alcohol used or contained'},
#{name: 'Celery-free', apiparameter: 'celery-free', description: 'does not contain celery or derivatives'},
#{name: 'Crustcean-free', apiparameter: 'crustacean-free', description: 'does not contain crustaceans (shrimp, lobster etc.) or derivatives'},
{name: 'Dairy', apiparameter: 'dairy-free', description: 'No dairy; nolactose'},
{name: 'Eggs', apiparameter: 'egg-free', description: 'No eggs or products containing eggs'},
{name: 'Fish', apiparameter: 'fish-free', description: 'No fish or fish derivatives'},
{name: 'Gluten', apiparameter: 'gluten-free', description: 'No ingredients containing gluten'},
#{name: 'Kidney friendly', apiparameter: 'kidney-friendly', description: 'per serving  &#8211; phosphorus less than 250 mgANDpotassium less than 500 mgANDsodium: less than 500 mg'},
#{name: 'Kosher', apiparameter: 'kosher', description: 'contains only ingredients allowed by the kosher diet.However it does not guarante kosher preparation of the ingredients themselves'},
#{name: 'Low potassium', apiparameter: 'low-potassium', description: 'Less than 150mg per serving'},
#{name: 'Lupine-free', apiparameter: 'lupine-free', description: 'does not contain lupine or derivatives'},
#{name: 'Mustard-free', apiparameter: 'mustard-free', description: 'does not contain mustard or derivatives'},
#{name: 'n/a', apiparameter: 'low-fat-abs', description: 'Less than 3g of fat per serving'},
#{name: 'No oil added', apiparameter: 'No-oil-added', description: 'No oil added except to what is contained in the basic ingredients'},
#{name: 'No-sugar', apiparameter: 'low-sugar', description: 'No simple sugars &#8211; glucose, dextrose, galactose, fructose, sucrose, lactose, maltose'},
{name: 'Paleo', apiparameter: 'paleo', description: 'Excludes what are perceived to be agricultural products; grains, legumes, dairy products, potatoes, refined salt, refined sugar, and processed oils'},
{name: 'Peanuts', apiparameter: 'peanut-free', description: 'No peanuts or products containing peanuts'},
#{name: 'Pescatarian', apiparameter: 'pecatarian', description: 'Does not cotain meat or meat based products, can cotain dairy and fish'},
#{name: 'Pork-free', apiparameter: 'pork-free', description: 'does not contain pork or derivatives'},
#{name: 'Red meat-free', apiparameter: 'red-meat-free', description: 'does not contain beef, lamb, pork, duck, goose, game, horse, and other types of red meat or products containing red meat.'},
#{name: 'Sesame-free', apiparameter: 'sesame-free', description: 'does not contain sesame seed or derivatives'},
{name: 'Shellfish', apiparameter: 'shellfish-free', description: 'No shellfish or shellfish derivatives'},
{name: 'Soy', apiparameter: 'soy-free', description: 'No soy or products containing soy'},
#{name: 'Sugar-conscious', apiparameter: 'sugar-conscious', description: 'Less than 4g of sugar per serving'},
{name: 'Tree Nuts', apiparameter: 'tree-nut-free', description: 'No tree nuts or products containing tree nuts'},
{name: 'Vegan', apiparameter: 'vegan', description: 'No meat, poultry, fish, dairy, eggs or honey'},
{name: 'Vegetarian', apiparameter: 'vegetarian', description: 'No meat, poultry, or fish'},
#{name: 'Wheat-free', apiparameter: 'wheat-free', description: 'No wheat, can have gluten though'}

 ])

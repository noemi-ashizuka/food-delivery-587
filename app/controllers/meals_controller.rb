require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # ask the repository for the array of meals
    meals = @meal_repository.all
    # tell the view to display the meal
    @meals_view.display(meals)
  end

  def add
    # have view ask for meal =  name
    name = @meals_view.ask_for('name')
    # have view ask for meal =  price
    price = @meals_view.ask_for('price').to_i
    # create an instance of MEAL
    meal = Meal.new(name: name, price: price)
    # give the meal to the repository
    @meal_repository.create(meal)
  end
end

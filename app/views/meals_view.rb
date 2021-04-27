require_relative 'base_view'

class MealsView < BaseView
  def display(meals) # an array of instances
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} - ¥#{meal.price}"
    end
  end
end

# meals_view.ask_for('whatever')

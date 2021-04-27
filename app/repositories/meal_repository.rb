require 'csv'
require_relative '../models/meal'

class MealRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1 # we use this to give to the next instance that needs an id
    load_csv if File.exist?(@csv_file_path) # this breaking when there's no csv file
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      #<CSV::Row id:"1" name:"tonkatsu" price:"900">

      row[:id] = row[:id].to_i # turn id into integer
      row[:price] = row[:price].to_i # turn price into integer
      @meals << Meal.new(row)
    end
    @next_id = @meals.any? ? @meals.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end

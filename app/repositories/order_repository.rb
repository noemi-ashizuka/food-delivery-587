require 'csv'
require_relative '../models/order'

class OrderRepository

  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @csv_file_path = csv_file_path
    @orders = []
    @next_id = 1 # we use this to give to the next instance that needs an id
    load_csv if File.exist?(@csv_file_path) # this breaking when there's no csv file
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select {|order| order.employee == employee }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i # turn id into integer
      # convert the ids into instances
      # hash[new_key] = new_value
      meal_id = row[:meal_id].to_i
      row[:meal] = @meal_repository.find(meal_id)
      customer_id = row[:customer_id].to_i
      row[:customer] = @customer_repository.find(customer_id)
      employee_id = row[:employee_id].to_i
      row[:employee] = @employee_repository.find(employee_id)
      row[:delivered] = row[:delivered] == 'true'
      @orders << Order.new(row)
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end

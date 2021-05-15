require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def add
    # ask the meal repo to give me all the meals
    meals = @meal_repository.all
    # display all the meals
    @meals_view.display(meals)
    # ask for an index of a meal
    meal_index = @meals_view.ask_for('number of meal').to_i - 1
    # get the meal instance from the repository
    meal = meals[meal_index] # instance

    # ask the meal repo to give me all the meals
    customers = @customer_repository.all
    # display all the customers
    @customers_view.display(customers)
    # ask for an index of a customer
    customer_index = @customers_view.ask_for('number of customer').to_i - 1
    # get the customer instance from the repository
    customer = customers[customer_index] # instance
    
    # ask the meal repo to give me all the meals
    employees = @employee_repository.all_riders
    # display all the employees
    @employees_view.display(employees)
    # ask for an index of a employee
    employee_index = @employees_view.ask_for('number of employee').to_i - 1
    # get the employee instance from the repository
    employee = employees[employee_index] # instance

    order = Order.new(meal: meal, customer: customer, employee: employee)

    @order_repository.create(order)
  end

  def list_my_orders(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(orders)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(orders)
    index = @orders_view.ask_for('number of the order to mark').to_i - 1
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end
end
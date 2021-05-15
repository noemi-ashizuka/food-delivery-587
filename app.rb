require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'
require_relative 'app/repositories/employee_repository'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/repositories/order_repository'
require_relative 'app/controllers/orders_controller'
require_relative 'router'

meals_csv = File.join(__dir__, 'data/meals.csv')
meal_repository = MealRepository.new(meals_csv)
meals_controller = MealsController.new(meal_repository)

customers_csv = File.join(__dir__, 'data/customers.csv')
customer_repository = CustomerRepository.new(customers_csv)
customers_controller = CustomersController.new(customer_repository)

employees_csv = File.join(__dir__, 'data/employees.csv')
employee_repository = EmployeeRepository.new(employees_csv)
sessions_controller = SessionsController.new(employee_repository)

orders_csv = File.join(__dir__, 'data/orders.csv')
order_repository = OrderRepository.new(orders_csv, meal_repository, customer_repository, employee_repository)
orders_controller = OrdersController.new(meal_repository, customer_repository, employee_repository, order_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)
router.run

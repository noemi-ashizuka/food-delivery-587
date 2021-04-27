require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # ask the repository for the array of customers
    customers = @customer_repository.all
    # tell the view to display the customer
    @customers_view.display(customers)
  end

  def add
    # have view ask for customer =  name
    name = @customers_view.ask_for('name')
    # have view ask for customer =  address
    address = @customers_view.ask_for('address')
    # create an instance of customer
    customer = Customer.new(name: name, address: address)
    # give the customer to the repository
    @customer_repository.create(customer)
  end
end

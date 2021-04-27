require_relative 'base_view'

class CustomersView < BaseView
  def display(customers) # an array of instances
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - #{customer.address}"
    end
  end
end

# customers_view.ask_for('whatever')

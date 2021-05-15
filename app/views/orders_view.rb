class OrdersView < BaseView
  def display(orders) # an array of instances
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} - #{order.customer.name}"
      puts "#{order.customer.address} - Rider: #{order.employee.username}"
    end
  end
end

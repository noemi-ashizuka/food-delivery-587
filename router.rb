class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    puts "Welcome to the Le Wagon Restaurant!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
      # when 3 then @controller.import
      # when 4 then @controller.mark_as_done
      # when 5 then @controller.destroy
    when 9 then stop
    else
      puts "Please press 1, 2, 3, 4 or 9"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    # puts "3 - Import a recipe"
    # puts "4 - Mark a recipe as done"
    # puts "5 - Destroy a recipe"
    puts "9 - Stop and exit the program"
  end
end

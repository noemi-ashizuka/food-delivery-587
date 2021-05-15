class SessionsView < BaseView
  def wrong_credentials
    puts "Sorry, wrong username or password, please try again"
  end

  def welcome(employee)
    puts "Welcome #{employee.username}"
  end
end

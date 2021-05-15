require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def sign_in
    # use the view to ask for username
    username = @sessions_view.ask_for('username')
    # use the view to ask for password
    password = @sessions_view.ask_for('password')
    # ask the repo to give us the employee instance
    employee = @employee_repository.find_by_username(username) # instance / nil
    # check if the employee exists and the password matches the one in the repo
    if employee && employee.password == password
      # if yes welcome the user
      @sessions_view.welcome(employee)
      return employee
    else
      # if not tell the user to try again
      @sessions_view.wrong_credentials
      sign_in
    end
  end
end

class Employee
  attr_accessor :id
  attr_reader :username, :password, :role

  def initialize(attributes = {})
    # id, username, password, role
    @id = attributes[:id] # integer
    @username = attributes[:username] # string
    @password = attributes[:password] # string
    @role = attributes[:role] # string
  end

  def manager?
    @role == 'manager'
  end

  def rider?
    @role == 'rider'
  end
end

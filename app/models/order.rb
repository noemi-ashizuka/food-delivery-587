class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # meal instance
    @customer = attributes[:customer] # customer instance
    @employee = attributes[:employee] # employee instance
    @delivered = attributes[:delivered] || false # boolean
  end

  def deliver!
    @delivered = true
  end
  
  def delivered?
    @delivered
  end
end

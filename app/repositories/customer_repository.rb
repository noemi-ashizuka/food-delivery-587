require 'csv'
require_relative '../models/customer'

class CustomerRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1 # we use this to give to the next instance that needs an id
    load_csv if File.exist?(@csv_file_path) # this breaking when there's no csv file
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      #<CSV::Row id:"1" name:"tonkatsu" price:"900">

      row[:id] = row[:id].to_i # turn id into integer
      @customers << Customer.new(row)
    end
    @next_id = @customers.any? ? @customers.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'address']
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end

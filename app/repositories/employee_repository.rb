require 'csv'
require_relative '../models/employee'

class EmployeeRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    @next_id = 1 # we use this to give to the next instance that needs an id
    load_csv if File.exist?(@csv_file_path) # this breaking when there's no csv file
  end

  def all
    @employees
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i # turn id into integer
      @employees << Employee.new(row)
 
    end
    @next_id = @employees.any? ? @employees.last.id + 1 : 1
  end
end

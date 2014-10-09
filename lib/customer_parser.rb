require_relative 'customer'
require 'csv'

class CustomerParser
	attr_reader :rows

  def initialize(file_path)
    @rows = CSV.open(file_path, headers: true, header_converters: :symbol)
  end

  def all(repository)
    rows.map {|row| Customer.new(row, repository)}
  end

end

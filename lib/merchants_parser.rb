require_relative 'merchants'
require 'csv'

class MerchantsParser
	attr_reader :rows

  def initialize(file_path)
    @rows = CSV.open(file_path, headers: true, header_converters: :symbol)
  end

  def all(repository)
    rows.map {|row| Merchants.new(row, repository)}
  end
end

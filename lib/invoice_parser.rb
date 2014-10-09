require_relative 'invoice'
require 'csv'

class InvoiceParser
	attr_reader :rows

	def initialize(file_path)
		@rows = CSV.open(file_path, headers: true, header_converters: :symbol)
	end

	def all(repository)
		rows.map {|row| Invoice.new(row, repository)}
	end
end

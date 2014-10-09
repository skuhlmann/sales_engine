require_relative 'invoice_item'
require 'csv'

class InvoiceItemParser
	attr_reader :rows

	def initialize(file_path)
		@rows = CSV.open(file_path, headers: true, header_converters: :symbol)
	end

	def all(repository)
		rows.map {|row| InvoiceItem.new(row, repository)}
	end
end

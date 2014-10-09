require_relative 'item'
require 'csv'

class ItemParser
	attr_reader :rows

	def initialize(file_path)
		@rows = CSV.open(file_path, headers: true, header_converters: :symbol)
	end

	def all(repository)
		rows.map {|row| Item.new(row, repository)}
	end
end

require 'bigdecimal'
require 'bigdecimal/util'
require 'time'


class Item
	attr_reader :id,
							:name,
							:description,
							:unit_price,
							:merchant_id,
							:created_at,
							:updated_at,
							:repository

	def initialize(data, repository)
		@id          = data[:id].to_i
		@name        = data[:name]
		@description = data[:description]
		@unit_price  = data[:unit_price].to_d/100
		@merchant_id = data[:merchant_id].to_i
		@created_at  = Date.parse(data[:created_at])
		@updated_at  = Date.parse(data[:updated_at])
		@repository	 = repository
	end

	def invoice_items
		repository.find_invoice_items_for(id)
	end

	def merchant
		repository.find_merchant_for(merchant_id)
	end

	def best_day
		invoices = invoice_items.group_by {|invoice_item| invoice_item.invoice.created_at}
		hash = Hash.new
		invoices.each do |date, invoice_items| 
			hash[date] = invoice_items.reduce(0) {|sum, invoice_item| sum + invoice_item.quantity}
		end
		best_day = hash.max_by { |date, total_quantity| total_quantity }[0]
	end

	def total_revenue
		invoice_items.reduce(0) {|sum, invoice_item| sum + (invoice_item.quantity * invoice_item.unit_price)}
	end

	def total_quantity 
		successful_invoice_items = invoice_items.select {|invoice_item| invoice_item.is_successful?}
		successful_invoice_items.reduce(0) {|sum, invoice_item| sum + invoice_item.quantity}
	end

end

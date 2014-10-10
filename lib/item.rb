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
		@created_at  = data[:created_at].split(" ")[0]
		@updated_at  = data[:updated_at].split(" ")[0]
		@repository	 = repository
	end

	def invoice_items
		repository.find_invoice_items_for(id)
	end

	def merchant
		repository.find_merchant_for(merchant_id)
	end

end

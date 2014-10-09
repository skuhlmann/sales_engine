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
		@id          = data[:id]
		@name        = data[:name].downcase
		@description = data[:description].downcase
		@unit_price  = data[:unit_price]
		@merchant_id = data[:merchant_id]
		@created_at  = data[:created_at].split(" ")[0]
		@updated_at  = data[:updated_at].split(" ")[0]
		@repository	 = repository
	end

	def invoice_items
		repository.find_invoice_items_for(id)
	end

	def merchant
		repository.find_merchant_for(id)
	end

end

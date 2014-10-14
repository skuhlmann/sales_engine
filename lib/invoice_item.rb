class InvoiceItem
	attr_reader :id,
					  	:item_id,
						  :invoice_id,
						  :quantity,
						  :unit_price,
						  :created_at,
						  :updated_at,
						  :repository

	def initialize(data, repository)
		@id         = data[:id].to_i
		@item_id    = data[:item_id].to_i
		@invoice_id = data[:invoice_id].to_i
		@quantity   = data[:quantity].to_i
		@unit_price = data[:unit_price].to_d/100
		@created_at = Date.parse(data[:created_at])
		@updated_at = Date.parse(data[:updated_at])
		@repository = repository
	end

	def invoice
		repository.find_invoice_for(invoice_id)
	end

	def item
		repository.find_item_for(item_id)
	end

end

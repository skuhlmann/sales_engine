class InvoiceItemRepository
	attr_reader :invoice_items, :sales_engine

	def initialize(invoice_items, sales_engine)
		@invoice_items = invoice_items 
		@sales_engine  = sales_engine
	end

	def all
		invoice_items
	end

	def random
		invoice_items.sample
	end

	def find_by(attribute, value)
		invoice_items.find {|invoice_item| invoice_item.send(attribute.to_sym) == value}
	end

	def find_all_by(attribute, value)
		invoice_items.find_all {|invoice_item| invoice_item.send(attribute.to_sym) == value}
	end

	def find_by_id(value); find_by(:id, value) end
	def find_by_item_id(value); find_by(:item_id, value) end
	def find_by_invoice_id(value); find_by(:invoice_id, value) end
	def find_by_quantity(value); find_by(:quantity, value) end
	def find_by_unit_price(value); find_by(:unit_price, value) end
	def find_by_created_at(value); find_by(:created_at, value) end
	def find_by_updated_at(value); find_by(:updated_at, value) end

	def find_all_by_id(value); find_all_by(:id, value) end
	def find_all_by_item_id(value); find_all_by(:item_id, value) end
	def find_all_by_invoice_id(value); find_all_by(:invoice_id, value) end
	def find_all_by_quantity(value); find_all_by(:quantity, value) end
	def find_all_by_unit_price(value); find_all_by(:unit_price, value) end
	def find_all_by_created_at(value); find_all_by(:created_at, value) end
	def find_all_by_updated_at(value); find_all_by(:updated_at, value) end

	def find_invoice_for(id)
		sales_engine.find_invoice_by_invoice_item(id)
	end
	
	def find_item_for(id)
		sales_engine.find_item_by_invoice_item(id)
	end

end
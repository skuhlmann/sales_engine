require_relative 'invoice_item_parser'
require_relative 'invoice_item'

class InvoiceItemRepository
	attr_reader :invoice_items, :sales_engine

	def initialize(file_path, sales_engine)
		@invoice_items = InvoiceItemParser.new(file_path).all(self)
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

	def find_invoice_for(invoice_id)
		sales_engine.find_invoice_by_invoice_id(invoice_id)
	end

	def find_item_for(item_id)
		sales_engine.find_item_by_invoice_item(item_id)
	end

	def has_successful_transaction?(invoice_id)
		sales_engine.invoice_item_has_successful_transaction?(invoice_id)
	end

	def create_invoice_items(invoice_id, item, quantity)
		data = { 				
						id: "#{invoice_items.last.id + 1}",
						item_id: item.id,
						invoice_id: invoice_id,
						quantity: quantity,
						unit_price: item.unit_price,
						created_at: "#{Date.new}",
						updated_at: "#{Date.new}"
					 }
		@invoice_items << InvoiceItem.new(data, self)
	end
	
  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

end

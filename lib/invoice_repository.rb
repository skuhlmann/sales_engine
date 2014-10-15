require_relative 'invoice_parser'
require_relative 'invoice'

class InvoiceRepository
	attr_reader :invoices, :sales_engine

	def initialize(file_path, sales_engine)
		@invoices     = InvoiceParser.new(file_path).all(self)
		@sales_engine = sales_engine
	end

	def all
		invoices
	end

	def random
		invoices.sample
	end

	def find_by(attribute, value)
		invoices.find {|invoice| invoice.send(attribute.to_sym) == value}
	end

	def find_all_by(attribute, value)
		invoices.find_all {|invoice| invoice.send(attribute.to_sym) == value}
	end

	def find_by_id(value); find_by(:id, value) end
	def find_by_customer_id(value); find_by(:customer_id, value) end
	def find_by_merchant_id(value); find_by(:merchant_id, value) end
	def find_by_status(value); find_by(:status, value.downcase) end
	def find_by_created_at(value); find_by(:created_at, value) end
	def find_by_updated_at(value); find_by(:updated_at, value) end

	def find_all_by_id(value); find_all_by(:id, value) end
	def find_all_by_customer_id(value); find_all_by(:customer_id, value) end
	def find_all_by_merchant_id(value); find_all_by(:merchant_id, value) end
	def find_all_by_status(value); find_all_by(:status, value.downcase) end
	def find_all_by_created_at(value); find_all_by(:created_at, value) end
	def find_all_by_updated_at(value); find_all_by(:updated_at, value) end

 	def find_transactions_for(id)
		sales_engine.find_transactions_by_invoice(id)
	end

	def find_successful_transactions_for(id)
		sales_engine.find_successful_transactions_by_invoice(id)
	end

	def find_items_for(id)
		sales_engine.find_items_by_invoice(id)
	end

	def find_customer_for(customer_id)
		sales_engine.find_customer_by_invoice(customer_id)
	end

	def find_merchant_for(merchant_id)
		sales_engine.find_merchant_by_invoice(merchant_id)
	end

	def find_invoice_items_for(id)
		sales_engine.find_invoice_items_by_invoice(id)
	end

	def has_successful_transaction?(id)
		sales_engine.invoice_has_successful_transaction?(id)
	end

	def create(attributes)
		data = { 
						id: "#{invoices.last.id + 1}",
						customer_id: attributes[:customer].id,
						merchant_id: attributes[:merchant].id,
						status: attributes[:status],
						created_at: "#{Date.new}",
						updated_at: "#{Date.new}"
					 }

		invoice = Invoice.new(data, self)

		invoice_id = data[:id]
		unique_items = attributes[:items].uniq
		quantities = attributes[:items].group_by {|item| item}
		unique_items.each do |item|
			quantity = quantities[item].count
			sales_engine.invoice_item_repository.create_invoice_items(invoice_id, item, quantity)
		end
		invoice
	end


	def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
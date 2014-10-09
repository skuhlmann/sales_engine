require_relative 'invoice_parser'
require_relative 'invoice'

class Invoice
	attr_reader :id,
					  	:customer_id,
						  :merchant_id,
						  :status,
						  :created_at,
						  :updated_at,
						  :repository

	def initialize(data, repository)
		@id          = data[:id].to_i
		@customer_id = data[:customer_id].to_i
		@merchant_id = data[:merchant_id]
		@status      = data[:status].downcase
		@created_at  = data[:created_at].split(" ")[0]
		@updated_at  = data[:updated_at].split(" ")[0]
		@repository  = repository
	end

	def transactions
		repository.find_transactions_for(id)
	end

	def invoice_items
		repository.find_invoice_items_for(id)
	end

	def items
		repository.find_items_for(id)
	end

	def customer
		repository.find_customer_for(id)
	end

	def merchant
		repository.find_merchant_for(id)
	end

end
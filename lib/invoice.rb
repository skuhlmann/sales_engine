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
		@merchant_id = data[:merchant_id].to_i
		@status      = data[:status]
		@created_at  = Date.parse(data[:created_at])
		@updated_at  = Date.parse(data[:updated_at])
		@repository  = repository
	end

	def transactions
		@transactions ||= repository.find_transactions_for(id)
	end

	def refresh_transactions
		@transactions = repository.find_transactions_for(id)
	end

	def successful_transactions
		@successful_transactions ||= repository.find_successful_transactions_for(id)
	end

	def customer
		@customer ||= repository.find_customer_for(customer_id)
	end

	def merchant
		@merchant ||= repository.find_merchant_for(merchant_id)
	end

	def invoice_items
		@invoice_items ||= repository.find_invoice_items_for(id)
	end

	def items
		@items ||= repository.find_items_for(id)
	end

	def is_successful?
		transactions.any? {|transaction| transaction.result == 'success'}
		#repository.has_successful_transaction?(id)
	end

	def charge(attributes)
		repository.create_transaction(attributes, id)
		refresh_transactions
	end

end

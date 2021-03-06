class Customer
	attr_reader :id,
						  :first_name,
						  :last_name,
						  :created_at,
						  :updated_at,
						  :repository

	def initialize(data, repository)
		@id         = data[:id].to_i
		@first_name = data[:first_name]
		@last_name  = data[:last_name]
		@created_at = Date.parse(data[:created_at])
		@updated_at = Date.parse(data[:updated_at])
		@repository = repository
	end

	def invoices
		repository.find_invoices_for(id)
	end

	def transactions
		@transaction ||= repository.find_transactions_for(id)
	end

	def successful_trans
		invoices.flat_map(&:transactions).select { |transaction| transaction.result == 'success' }
		# customer_transactions = invoices.flat_map { |invoices| invoices.transactions }
		# successful_transactions = customer_transactions.select { |transaction| transaction.result == 'success' }
	end

	def favorite_merchant
		invoices.flat_map(&:merchant).max_by { |invoices| invoices }
		# customer_invoices = invoices.flat_map { |invoices| invoices.merchant }
		# favorite_merchant = customer_invoices.max_by { |invoices| invoices }
	end

end

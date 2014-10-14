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
		@created_at = data[:created_at]
		@updated_at = data[:updated_at]
		@repository = repository
	end

	def invoices
		repository.find_invoices_for(id)
	end

	def transactions
		repository.find_transactions_for(id)
	end

	def favorite_merchant
		customer_invoices = invoices.map { |invoices| invoices.merchant }.flatten
		favorite_merchant = customer_invoices.max_by { |invoices| invoices }
	end

end

require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transactions_repository'

class SalesEngine
	attr_reader :directory,
							:customer_repository,
							:invoice_repository,
							:invoice_item_repository,
							:item_repository,
							:merchant_repository,
							:transactions_repository 


	def initialize(directory = "./data")
		@directory = directory
	end

	def startup
		@customer_repository ||= CustomerRepository.new("#{directory}/customers.csv", self)
		@invoice_repository ||= InvoiceRepository.new("#{directory}/invoices.csv", self)
		@invoice_item_repository ||= InvoiceItemRepository.new("#{directory}/invoice_items.csv", self)
		@item_repository ||= ItemRepository.new("#{directory}/items.csv", self)
		@merchant_repository ||= MerchantRepository.new("#{directory}/merchants.csv", self)
		@transaction_repository ||= TransactionsRepository.new("#{directory}/transactions.csv", self)
	end
end
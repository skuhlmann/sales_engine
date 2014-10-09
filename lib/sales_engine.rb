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
							:transaction_repository

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

	def find_invoices_by_customer(id)
		invoice_repository.find_all_by_customer_id(id)
	end

	def find_item_by_invoice_item(item_id)
		item_repository.find_by_id(item_id)
	end

	def find_invoice_by_invoice_id(invoice_id)
		invoice_repository.find_by_id(invoice_id)
	end

	def find_transactions_by_invoice(id)
		transaction_repository.find_all_by_invoice_id(id)
	end

	def find_customer_by_invoice(customer_id)
		customer_repository.find_by_id(customer_id)
	end

	def find_merchant_by_invoice(merchant_id)
		merchant_repository.find_by_id(merchant_id)
	end

	def find_invoice_items_by_invoice(id)
		invoice_item_repository.find_all_by_invoice_id(id)
	end

	def find_items_by_invoice(id)
		invoice_items = find_invoice_items_by_invoice(id)
		invoice_items.collect {|invoice_item| find_item_by_invoice_item(invoice_item.item_id)}
	end

	def find_invoice_by_transaction(invoice_id)
		invoice_repository.find_by_id(invoice_id)
	end

end

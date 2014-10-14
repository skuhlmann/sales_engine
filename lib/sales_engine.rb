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
		@customer_repository     ||= CustomerRepository.new(directory + "/customers.csv", self)
		@invoice_repository      ||= InvoiceRepository.new(directory + "/invoices.csv", self)
		@invoice_item_repository ||= InvoiceItemRepository.new(directory + "/invoice_items.csv", self)
		@item_repository         ||= ItemRepository.new(directory + "/items.csv", self)
		@merchant_repository     ||= MerchantRepository.new(directory + "/merchants.csv", self)
		@transaction_repository  ||= TransactionsRepository.new(directory + "/transactions.csv", self)
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

	def find_invoice_items_by_item(id)
		invoice_item_repository.find_all_by_item_id(id)
	end

	def find_merchant_by_item(merchant_id)
		merchant_repository.find_by_id(merchant_id)
	end

	def find_items_by_merchant(id)
		item_repository.find_all_by_merchant_id(id)
	end

	def find_invoices_by_merchant(id)
		invoice_repository.find_all_by_merchant_id(id)
	end

	def find_transactions_by_customer(id)
		customer_invoices = find_invoices_by_customer(id)
		customer_invoices.map(&:id)
	end

	def find_all_invoice_items_by_quantity(x)
		invoice_items_grouped = invoice_item_repository.all.group_by {|invoice_item| invoice_item.item_id}
		hash = Hash.new
		invoice_items_grouped.each do |item_id, invoice_items|
			hash[item_id] = invoice_items.reduce(0) {|sum, invoice_item| sum + invoice_item.quantity}
		end
		most_quantity = hash.sort_by {|item_id, total_quantity| total_quantity}.reverse.take(x)
		this = most_quantity.map {|element| item_repository.find_by_id(element[0])}
	end

end

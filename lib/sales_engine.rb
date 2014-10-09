require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transactions_repository'

class SalesEngine

	def initialize(data = "./data")
	end

	def startup
		#customers     = CustomerParser.new("/data/customers.csv", repository)
		invoices      = InvoiceParser.new("/data/invoices.csv", repository)
		invoice_items = InvoiceItemParser.new("/data/invoice_items.csv", repository)
		items         = ItemParser.new("/data/items.csv", repository)
		merchants     = MerchantsParser.new("/data/merchants.csv", repository)
		transactions  = TransactionsParser.new("/data/transactions.csv", repository)
	end

	def customer_repository 
		@customer_repository ||= CustomerRepository.new("/data/customers.csv", self)
	end

	def invoice_repository
		@invoice_repository ||= InvoiceRepository.new(invoices, self)
	end
		
	def invoice_item_repository
		@invoice_item_repository ||= InvoiceItemRepository.new(invoice_items, self)
	end
	
	def item_repository
		@item_repository ||= ItemRepository.new(items, sales_engine)
	end

	def merchant_repository
		@merchant_repository ||= MerchantRepository.new(merchants, sales_engine)
	end

	def	transaction_repository
		@transaction_repository ||= TransactionsRepository.new(transactions, sales_engine)
	end



end
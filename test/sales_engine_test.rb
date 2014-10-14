require_relative 'test_helper'

class SalesEngineTest < Minitest::Test 
	attr_reader :engine

	def setup
		@engine = SalesEngine.new("./test/support")
	end

	def test_it_has_a_directory
		assert engine.directory
	end

	def test_starts_up_with_repositories
		engine.startup 

		assert engine.customer_repository
		assert engine.invoice_repository      
		assert engine.invoice_item_repository 
		assert engine.item_repository         
		assert engine.merchant_repository     
		assert engine.transaction_repository
	end

	def test_finds_invoices_by_cust_id
		engine.startup
		results = engine.find_invoices_by_customer(2)

		assert_equal 9, results[0].id		
	end

	def test_finds_item_by_invoice_item_id
		engine.startup
		results = engine.find_item_by_invoice_item(8)

		assert_equal "Item Est Consequuntur", results.name
	end

	def test_finds_invoice_by_invoice_id
		engine.startup
		results = engine.find_invoice_by_invoice_id(13)

		assert_equal 3, results.customer_id
	end

	def test_finds_transactions_by_invoice_id
		engine.startup
		results = engine.find_transactions_by_invoice(10)

		assert_equal 9, results[0].id
	end

	def test_finds_customer_by_invoice
		engine.startup
		results = engine.find_customer_by_invoice(11)

		assert_equal "Logan", results.first_name
	end

	def test_finds_merchant_by_invoice
		engine.startup
		results = engine.find_merchant_by_invoice(13)

		assert_equal "Tillman Group", results.name
	end

	def test_finds_invoice_items_by_invoice
		engine.startup
		results = engine.find_invoice_items_by_invoice(1)

		assert_equal 1, results[0].id
	end

	def test_finds_items_by_invoice
		engine.startup
		results = engine.find_items_by_invoice(1)

		assert_equal "Test Item", results[0].name
	end

	def test_finds_invoice_by_transaction
		engine.startup
		results = engine.find_invoice_by_transaction(10)

		assert_equal 3, results.customer_id
	end

	def test_finds_invoice_items_by_item
		engine.startup
		results = engine.find_invoice_items_by_item(535)

		assert_equal 4, results[0].id
	end

	def test_finds_merchant_by_item
		engine.startup
		results = engine.find_merchant_by_item(12)

		assert_equal "Kozey Group", results.name
	end

	def test_find_items_by_merchant
		engine.startup
		results = engine.find_items_by_merchant(1)

		assert_equal "Item Qui Esse", results[0].name
	end

	def test_find_invoices_by_merchant
		engine.startup
		results = engine.find_invoices_by_merchant(75)

		assert_equal 2, results[0].id
	end

end
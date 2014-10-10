require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test 
	attr_reader :invoice_repository, :sales_engine

	def setup
		file_path = "./test/support/invoices.csv"
		@sales_engine = Minitest::Mock.new
		repository = Minitest::Mock.new
		@invoice_repository = InvoiceRepository.new(file_path, sales_engine)
	end

	def test_has_an_invoice_array
		assert_equal 14, invoice_repository.invoices.count
	end

	def test_returns_all_items
		results = invoice_repository.all

		assert_equal invoice_repository.invoices.count, results.count
	end

	def test_returns_a_random_invoice
		results = []
		100.times do 
			results << invoice_repository.random
		end
		results.uniq!

		refute results.count == 100
	end

	def test_finds_by_id
		results = invoice_repository.find_by_id(4)

		assert_equal 33, results.merchant_id
	end	

	def test_finds_by_customer_id
		results = invoice_repository.find_by_customer_id(2)

		assert_equal 9, results.id
	end	

	def test_finds_by_merchant_id
		results = invoice_repository.find_by_merchant_id(62)

		assert_equal 11, results.id
	end	

	def test_finds_by_status
		results = invoice_repository.find_by_status("shipped")

		assert_equal 1, results.id
	end	

	def test_finds_by_create_date
		results = invoice_repository.find_by_created_at("2012-03-10")

		assert_equal 3, results.id
	end

	def test_finds_by_update_date
		results = invoice_repository.find_by_updated_at("2012-03-21")

		assert_equal 12, results.id
	end

	def test_finds_all_by_customer_id
		results = invoice_repository.find_all_by_customer_id(3)

		assert_equal 4, results.count
		assert_equal 10, results[0].id
	end

	def test_finds_all_by_missing_value_returns_an_empty_array
		results = invoice_repository.find_all_by_id(1000000)

		assert_empty results
	end

	def test_delegates_find_transactions_for_to_sales_engine
		sales_engine.expect(:find_transactions_by_invoice, [], [1])
		invoice_repository.find_transactions_for(1)
		sales_engine.verify
	end

	def test_delegates_find_invoice_items_for_to_sales_engine
		sales_engine.expect(:find_invoice_items_by_invoice, [], [1])
		invoice_repository.find_invoice_items_for(1)
		sales_engine.verify
	end

	def test_delegates_find_items_for_to_sales_engine
		sales_engine.expect(:find_items_by_invoice, [], [1])
		invoice_repository.find_items_for(1)
		sales_engine.verify
	end

	def test_delegates_find_customer_for_to_sales_engine
		sales_engine.expect(:find_customer_by_invoice, [], [1])
		invoice_repository.find_customer_for(1)
		sales_engine.verify
	end

	def test_delegates_find_merchant_for_to_sales_engine
		sales_engine.expect(:find_merchant_by_invoice, [], [1])
		invoice_repository.find_merchant_for(1)
		sales_engine.verify
	end
end
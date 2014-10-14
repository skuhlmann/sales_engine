require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test 
	attr_reader :invoice_item_repository, :sales_engine

	def setup
		file_path = "./test/support/invoice_items.csv"
		@sales_engine = Minitest::Mock.new
		repository = Minitest::Mock.new
		@invoice_item_repository = InvoiceItemRepository.new(file_path, sales_engine)
	end

	def test_has_an_invoice_items_array
		assert_equal 14, invoice_item_repository.invoice_items.count
	end

	def test_returns_all_items
		results = invoice_item_repository.all

		assert_equal invoice_item_repository.invoice_items.count, results.count
	end

	def test_returns_random_invoice_item
		results = []
		100.times do 
			results << invoice_item_repository.random
		end
		results.uniq!

		refute results.count == 100
	end

	def test_finds_by_id
		results = invoice_item_repository.find_by_id(4)

		assert_equal 3, results.quantity
	end	

	def test_finds_by_item_id
		results = invoice_item_repository.find_by_item_id(529)

		assert_equal 5, results.id
	end	

	def test_finds_by_invoice_id
		results = invoice_item_repository.find_by_invoice_id(2)

		assert_equal 9, results.id
	end	

	def test_finds_by_quantity
		results = invoice_item_repository.find_by_quantity(8)

		assert_equal 3, results.id
	end	

	def test_finds_by_unit_price
		results = invoice_item_repository.find_by_unit_price(42.64)

		assert_equal 14, results.id
	end	

	def test_finds_by_create_date
		results = invoice_item_repository.find_by_created_at(Date.parse("2012-03-27"))

		assert_equal 1, results.id
	end

	def test_finds_by_update_date
		results = invoice_item_repository.find_by_updated_at(Date.parse("2012-03-27"))

		assert_equal 1, results.id
	end

	def test_finds_all_by_invoice_id
		results = invoice_item_repository.find_all_by_invoice_id(1)

		assert_equal 8, results.count
		assert_equal 4, results[3].id
	end

	def test_finds_all_by_missing_value_returns_an_empty_array
		results = invoice_item_repository.find_all_by_id(1000000)

		assert_empty results
	end

	def test_delegates_find_invoice_for_to_sales_engine
		sales_engine.expect(:find_invoice_by_invoice_id, [], [1])
		invoice_item_repository.find_invoice_for(1)
		sales_engine.verify
	end

		def test_delegates_find_item_for_to_sales_engine
		sales_engine.expect(:find_item_by_invoice_item, [], [1])
		invoice_item_repository.find_item_for(1)
		sales_engine.verify
	end

end
require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test
	attr_reader :item_repository, :repository, :sales_engine

	def setup
		file_path = "./test/support/test_items.csv"
		@sales_engine = Minitest::Mock.new
		repository = Minitest::Mock.new
		@item_repository = ItemRepository.new(file_path, sales_engine)
	end

	def test_instantiates_with_items_array

		assert_equal 14,item_repository.items.count
	end

	def test_returns_all_items
		results = item_repository.all

		assert_equal item_repository.items.count, results.count
	end

	def test_returns_a_random_item
		results = []
		100.times do 
			results << item_repository.random
		end
		results.uniq!

		refute results.count == 100
	end

	def test_finds_all_by_missing_value_returns_an_empty_array
		results = item_repository.find_all_by_id(1000000)

		assert_empty results
	end

	def test_finds_by_id
		results = item_repository.find_by_id(4)

		assert_equal "Item Nemo Facere", results.name
	end

	def test_finds_by_name
		results = item_repository.find_by_name("Item Expedita Fuga")

		assert_equal 7, results.id
	end

	def test_finds_by_description
		results = item_repository.find_by_description("Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.")

		assert_equal 4, results.id
	end

	def test_finds_by_unit_price
		results = item_repository.find_by_unit_price(BigDecimal.new("67076")/100)

		assert_equal 2, results.id
	end

	def test_finds_by_merchant_id
		results = item_repository.find_by_merchant_id(1)

		assert_equal 1, results.id
	end

	def test_finds_by_created_date
		results = item_repository.find_by_created_at("2012-03-27")

		assert_equal 1, results.id
	end

	def test_finds_by_updated_at
		results = item_repository.find_by_updated_at("2012-03-27")

		assert_equal 1, results.id
	end

	def test_finds_all_by_merchant_id
		results = item_repository.find_all_by_merchant_id(1)

		assert_equal 14, results.count
		assert_equal "Item Itaque Consequatur", results[13].name
	end

	def test_delegates_find_merchant_to_sales_engine
		sales_engine.expect(:find_merchant_by_item, [], [1])
		item_repository.find_merchant_for(1)
		sales_engine.verify
	end

	def test_delegates_find_invoice_items_to_sales_engine
		sales_engine.expect(:find_invoice_items_by_item, [], [1])
		item_repository.find_invoice_items_for(1)
		sales_engine.verify
	end
end

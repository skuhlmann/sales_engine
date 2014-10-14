require_relative 'test_helper'

class ParserTest < MiniTest::Test

	def test_loads_an_item_csv
		file_path = "./test/support/items.csv"
		repository = Minitest::Mock.new
		items = ItemParser.new(file_path).all(repository)

		assert_equal 1, items[0].id
		assert_equal "Item Autem Minima", items[1].name
		assert_equal "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.", items[3].description
		assert_equal 42.91, items[3].unit_price
		assert_equal 1, items[4].merchant_id
		assert_equal Date.parse("2012-03-27"), items[5].created_at
		assert_equal Date.parse("2012-03-27"), items[6].updated_at
	end

	def test_loads_an_invoice_csv
		file_path = "./test/support/invoices.csv"
		repository = Minitest::Mock.new
		invoices = InvoiceParser.new(file_path).all(repository)

		assert_equal 6, invoices[5].id
		assert_equal 1, invoices[1].customer_id
		assert_equal 78, invoices[2].merchant_id
		assert_equal "shipped", invoices[3].status
		assert_equal Date.parse("2012-03-09"), invoices[5].created_at
		assert_equal Date.parse("2012-03-07"), invoices[6].updated_at
	end

	def test_loads_an_invoice_item_csv
		file_path = "./test/support/invoice_items.csv"
		repository = Minitest::Mock.new
		invoice_items = InvoiceItemParser.new(file_path).all(repository)

		assert_equal 1, invoice_items[0].id
		assert_equal 528, invoice_items[1].item_id
		assert_equal 1, invoice_items[2].invoice_id
		assert_equal 3, invoice_items[3].quantity
		assert_equal BigDecimal.new("79140")/100, invoice_items[4].unit_price
		assert_equal Date.parse("2012-03-27"), invoice_items[5].created_at
		assert_equal Date.parse("2012-03-27"), invoice_items[6].updated_at
	end

	def test_loads_a_customer_csv
		file_path = "./test/support/customers.csv"
		repository = Minitest::Mock.new
		customers = CustomerParser.new(file_path).all(repository)

		assert_equal 1 , customers[0].id
		assert_equal "Joey", customers[0].first_name
		assert_equal "Ondricka", customers[0].last_name
		assert_equal Date.parse("2012-03-27"), customers[0].created_at
		assert_equal Date.parse("2012-03-27"), customers[0].updated_at
	end

	def test_loads_a_merchant_csv
		file_path = "./test/support/merchants.csv"
		repository = Minitest::Mock.new
		merchants = MerchantsParser.new(file_path).all(repository)

		assert_equal 1, merchants[0].id
		assert_equal "Schroeder-Jerde", merchants[0].name
		assert_equal Date.parse("2012-03-27"), merchants[0].created_at
		assert_equal Date.parse("2012-03-27"), merchants[0].updated_at
	end

	def test_loads_a_transaction_csv
		file_path = "./test/support/transactions.csv"
		repository = Minitest::Mock.new
		transactions = TransactionsParser.new(file_path).all(repository)

		assert_equal 1, transactions[0].id
		assert_equal 1, transactions[0].invoice_id
		assert_equal "4654405418249632", transactions[0].credit_card_number
		assert_equal "success", transactions[0].result
		assert_equal Date.parse("2012-03-27"), transactions[0].created_at
		assert_equal Date.parse("2012-03-27"), transactions[0].updated_at
	end

end

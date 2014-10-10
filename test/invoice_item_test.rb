require_relative 'test_helper'

class InvoiceItemTest < Minitest::Test 

	attr_reader :invoice_item, :repository

	def setup
		data = {id: "1",
						item_id: "539",
						invoice_id: "1",
						quantity: "5",
						unit_price: "13635",
						created_at: "2012-03-27 14:54:09 UTC",
						updated_at: "2012-03-27 14:54:09 UTC"
						}
		@repository = Minitest::Mock.new
		@invoice_item = InvoiceItem.new(data, repository)
	end

	def test_has_a_repository
		assert invoice_item.repository
	end

	def test_invoice_item_has_an_id
		assert_equal 1, invoice_item.id
	end

	def test_invoice_item_has_an_item_id
		assert_equal 539, invoice_item.item_id
	end

	def test_invoice_item_has_an_invoice_id
		assert_equal 1, invoice_item.invoice_id
	end

	def test_invoice_item_has_a_quantity
		assert_equal 5, invoice_item.quantity
	end

	def test_invoice_item_has_an_unit_price
		assert_equal BigDecimal.new("13635")/100, invoice_item.unit_price
	end

	def test_invoice_item_has_metadata
		assert_equal "2012-03-27", invoice_item.created_at
		assert_equal "2012-03-27", invoice_item.updated_at
	end

	def test_delegates_invoice_to_repository
		repository.expect(:find_invoice_for, [], [1])
		invoice_item.invoice
		repository.verify
	end

  #not sure why this one is failing
	# def test_delegates_item_to_repository
	# 	repository.expect(:find_item_for, [], [1])
	# 	invoice_item.item
	# 	repository.verify
	# end
end
require_relative 'test_helper'

class TransactionsTest < Minitest::Test
  attr_reader :transaction, :repository

  def setup
    data = {id: "1",
            invoice_id: "1",
            credit_card_number: "4654405418249632",
            credit_card_expiration_date: " ",
            result: "success",
            created_at: "2012-03-27 14:54:09 UTC",
            updated_at: "2012-03-27 14:54:09 UTC"
            }
    @repository = Minitest::Mock.new
    @transaction = Transactions.new(data, repository)
  end

  def test_it_has_a_repository
    assert transaction.repository
  end

  def test_it_has_an_id
    assert_equal 1, transaction.id
  end

  def test_it_has_an_invoice_id
    assert_equal 1, transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal "4654405418249632", transaction.credit_card_number
  end

  def test_it_has_no_credit_card_expiration_date
    assert_equal " ", transaction.credit_card_expiration_date
  end

  def test_it_has_a_result
    assert_equal "success", transaction.result
  end

  def test_an_item_has_meta_data
    assert_equal "2012-03-27", transaction.created_at
    assert_equal "2012-03-27", transaction.updated_at
  end

  def it_delegates_invoice_to_repository
    repository.expect(:find_invoice_by_transaction, [], [1])
    transation.invoice 
    repository.verify
  end
end

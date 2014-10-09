require_relative 'test_helper'

class TransactionsRepositoryTest < Minitest::Test
attr_reader :transactions_repository, :sales_engine

  def setup
    file_path = "./test/support/test_transactions.csv"
    @sales_engine = Minitest::Mock.new
    repository = Minitest::Mock.new
    transactions = TransactionsParser.new(file_path, repository).all
    @transactions_repository = TransactionsRepository.new(transactions, sales_engine)
  end

  def test_instantiates_with_transactions_array

    assert_equal 14,transactions_repository.transactions.count
  end

  def test_returns_all_transactions
    results = transactions_repository.all

    assert_equal transactions_repository.transactions.count, results.count
  end

  def test_returns_a_random_transaction
    results = transactions_repository.random

    assert_equal 1, results.count
  end

  def test_finds_by_missing_value_returns_an_empty_array
    results = transactions_repository.find_by_id("1000000")

    assert_empty results
  end

  def test_finds_all_by_missing_value_returns_an_empty_array
    results = transactions_repository.find_all_by_id("1000000")

    assert_empty results
  end

  def test_finds_by_id
    results = transactions_repository.find_by_id("4")

    assert_equal "5", results.invoice_id
  end

  def test_finds_by_invoice_id
    results = transactions_repository.find_by_invoice_id("6")

    assert_equal "5", results.id
  end

  def test_finds_by_credit_card_number
    results = transactions_repository.find_by_credit_card_number("4540842003561938")

    assert_equal "8", results.id
  end

  def test_finds_by_result
    results = transactions_repository.find_by_result("success")

    assert_equal "1", results.id
  end

  def test_finds_by_created_date
    results = transactions_repository.find_by_created_at("2012-03-27")

    assert_equal "1", results.id
  end

  def test_finds_by_updated_at
    results = transactions_repository.find_by_updated_at("2012-03-27")

    assert_equal "1", results.id
  end

  def test_finds_all_by_result
    results = transactions_repository.find_all_by_result("success")

    assert_equal 11, results.count
  end

  def test_it_delegates_find_invoice_by_to_sales_engine
    sales_engine.expect(:find_invoice_by_transaction, [], ["1"])
    transactions_repository.find_invoice_for("1")
    sales_engine.verify
  end
end

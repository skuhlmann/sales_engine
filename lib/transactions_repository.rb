require_relative 'transactions_parser'
require_relative 'transactions'

class TransactionsRepository
  attr_reader :transactions, :sales_engine

  def initialize(transactions, sales_engine)
    @transactions = transactions
    @sales_engine = sales_engine
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by(attribute, value)
    transactions.find {|transactions| transactions.send(attribute.to_sym) == value}
  end

  def find_all_by(attribute, value)
    transactions.find_all {|transactions| transactions.send(attribute.to_sym) == value}
  end

  def find_by_id(value); find_by(:id, value) end
  def find_by_invoice_id(value); find_by(:invoice_id, value.downcase) end
  def find_by_credit_card_number(value); find_by(:credit_card_number, value.downcase) end
  def find_by_credit_card_expiration_date(value); find_by(:credit_card_expiration_date, value.downcase) end
  def find_by_result(value); find_by(:result, value.downcase) end
  def find_by_created_at(value); find_by(:created_at, value) end
  def find_by_updated_at(value); find_by(:updated_at, value) end

  def find_all_by_id(value); find_all_by(:id, value) end
  def find_all_by_invoice_id(value); find_all_by(:invoice_id, value.downcase) end
  def find_all_by_credit_card_number(value); find_all_by(:credit_card_number, value.downcase) end
  def find_all_by_credit_card_expiration_date(value); find_all_by(:credit_card_expiration_date, value.downcase) end
  def find_all_by_result(value); find_all_by(:result, value.downcase) end
  def find_all_by_created_at(value); find_all_by(:created_at, value) end
  def find_all_by_updated_at(value); find_all_by(:updated_at, value) end

  def find_invoice_for(id)
    sales_engine.find_invoice_by_transaction(id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end

require_relative 'transactions_parser'
require_relative 'transactions'

class TransactionsRepository
  attr_reader :transactions, :sales_engine

  def initialize(file_path, sales_engine)
    @transactions = TransactionsParser.new(file_path).all(self)
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
  def find_by_invoice_id(value); find_by(:invoice_id, value) end
  def find_by_credit_card_number(value); find_by(:credit_card_number, value) end
  def find_by_credit_card_expiration_date(value); find_by(:credit_card_expiration_date, value) end
  def find_by_result(value); find_by(:result, value.downcase) end
  def find_by_created_at(value); find_by(:created_at, value) end
  def find_by_updated_at(value); find_by(:updated_at, value) end

  def find_all_by_id(value); find_all_by(:id, value) end
  def find_all_by_invoice_id(value); find_all_by(:invoice_id, value) end
  def find_all_by_credit_card_number(value); find_all_by(:credit_card_number, value) end
  def find_all_by_credit_card_expiration_date(value); find_all_by(:credit_card_expiration_date, value) end
  def find_all_by_result(value); find_all_by(:result, value.downcase) end
  def find_all_by_created_at(value); find_all_by(:created_at, value) end
  def find_all_by_updated_at(value); find_all_by(:updated_at, value) end

  def find_invoice_for(invoice_id)
    sales_engine.find_invoice_by_transaction(invoice_id)
  end

  def create_transactions(attributes, id)
    data = {
            id: "#{transactions.last.id + 1}",
            created_at: "#{Date.new}",
            updated_at: "#{Date.new}",
            invoice_id: id,
            credit_card_number: attributes[:credit_card_number],
            credit_card_expiration_date: attributes[:credit_card_expiration_date],
            result: attributes[:result]
           }
    @transactions << Transactions.new(data, self)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end

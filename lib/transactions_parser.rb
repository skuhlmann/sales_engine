require_relative 'transactions'
require 'csv'

class TransactionsParser
  attr_reader :rows
  
  def initialize(file_path)
    @rows = CSV.open(file_path, headers: true, header_converters: :symbol)
  end

  def all(repository)
    rows.map {|row| Transactions.new(row, repository)}
  end
end

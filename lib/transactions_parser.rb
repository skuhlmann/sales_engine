require_relative 'transactions'
require 'csv'

class TransactionsParser
  attr_reader :rows, :repository
  
  def initialize(file_path, repository)
    @rows = CSV.open(file_path, headers: true, header_converters: :symbol)
  end

  def all
    rows.map {|row| Transactions.new(row, repository)}
  end
end

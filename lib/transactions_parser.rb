class TransactionsParser
  attr_reader :parser

  def initialize(file_path)
    @parser = Parser.new(file_path)
  end

  def all
    parser.rows.map {|row| Transactions.new(row)}
  end
end

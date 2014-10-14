class Merchants
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:created_at])
    @repository = repository
  end

  def items
    repository.find_items_for(id)
  end

  def invoices
    repository.find_invoices_for(id)
  end

  def invoices_by_date(date)
    invoices.select {|invoice| invoice.created_at == date}
  end

  def revenue(date=nil)
    if date == nil
      merchant_transactions = invoices.map {|invoice| invoice.successful_transactions}.flatten
    else
      merchant_transactions = invoices_by_date(date).map {|invoice| invoice.successful_transactions}.flatten
    end
    successful_invoices = merchant_transactions.map {|transaction| transaction.invoice}
    successful_invoice_items = successful_invoices.map {|invoice| invoice.invoice_items}.flatten
    total_revenue = successful_invoice_items.reduce(0) {|sum, invoice_item| sum + (invoice_item.quantity * invoice_item.unit_price)}
  end

  def favorite_customer
    
  end

end

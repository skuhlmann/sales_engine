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
    @items ||= repository.find_items_for(id)
  end

  def invoices
    @invoices ||= repository.find_invoices_for(id)
  end

  def invoice_items
    @invoice_items ||= invoices.flat_map(&:invoice_items)
  end

  def invoices_by_date(date)
    invoices.select {|invoice| invoice.created_at == date}
  end

  def revenue(date=nil)
    if date == nil
      revenue_invoice_items = invoices.select(&:is_successful?).flat_map(&:invoice_items)
    else
      revenue_invoice_items = invoices_by_date(date).select(&:is_successful?).flat_map(&:invoice_items)
    end   
    total_revenue = revenue_invoice_items.reduce(0) {|sum, invoice_item| sum + (invoice_item.quantity * invoice_item.unit_price)}
  end

  def successful_invoice_items
    invoice_items.select(&:is_successful?)
  end

  def items_sold
    successful_invoice_items.reduce(0) {|sum, invoice_item| sum + invoice_item.quantity}
  end

  def favorite_customer
    merchant_customers = invoices.flat_map(&:customer)
    favorite_customer = merchant_customers.uniq.max_by { |customer| merchant_customers.count(customer)}
  end

  def customers_with_pending_invoices
    invoices.reject {|invoice| invoice.is_successful?}.map {|invoice| invoice.customer}
  end
end

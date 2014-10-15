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
    #invoices.flat_map {|invoice| invoice.invoice_items}
  end

  def invoices_by_date(date)
    invoices.select {|invoice| invoice.created_at == date}
  end

  def revenue(date=nil)
    if date == nil
      successful_invoices = invoices.select {|invoice| invoice.is_successful?}
    else
      successful_invoices = invoices_by_date(date).select {|invoice| invoice.is_successful?} 
    end   
    successful_invoice_items = successful_invoices.flat_map {|invoice| invoice.invoice_items}
    total_revenue = successful_invoice_items.reduce(0) {|sum, invoice_item| sum + (invoice_item.quantity * invoice_item.unit_price)}
  end

  def items_sold
    successful_invoice_items = invoice_items.select {|invoice_item| invoice_item.is_successful?}
    successful_invoice_items.reduce(0) {|sum, invoice_item| sum + invoice_item.quantity}
  end

  def favorite_customer
    
  end
end

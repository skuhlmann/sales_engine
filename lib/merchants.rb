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
end
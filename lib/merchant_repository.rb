require_relative 'merchants_parser'
require_relative 'merchants'

class MerchantRepository
	attr_reader :merchants, :sales_engine

	def initialize(file_path, sales_engine)
		@merchants    = MerchantsParser.new(file_path).all(self)
		@sales_engine = sales_engine
	end

	def all
		merchants
	end

	def random
		merchants.sample
	end

	def find_by(attribute, value)
		merchants.find {|merchant| merchant.send(attribute.to_sym) == value}
	end

	def find_all_by(attribute, value)
		merchants.find_all {|merchant| merchant.send(attribute.to_sym) == value}
	end

	def find_by_id(value); find_by(:id, value) end
	def find_by_created_at(value); find_by(:created_at, value) end
	def find_by_updated_at(value); find_by(:updated_at, value) end

	def find_all_by_id(value); find_all_by(:id, value) end
	def find_all_by_created_at(value); find_all_by(:created_at, value) end
	def find_all_by_updated_at(value); find_all_by(:updated_at, value) end

	def find_by_name(value)
		merchants.find {|merchant| merchant.name.downcase == value.downcase}
	end

	def find_all_by_name(value)
		merchants.find_all {|merchant| merchant.name.downcase == value.downcase}
	end

	def find_items_for(id)
		sales_engine.find_items_by_merchant(id)
	end

	def find_invoices_for(id)
		sales_engine.find_invoices_by_merchant(id)
	end

	def find_customer_with_pending_invoices(customer_id)
		sales_engine.find_customers_with_pending_invoices(customer_id)
	end

	def most_items(x)
		merchants.sort_by(&:items_sold).reverse.take(x)
	end

	def revenue(date)
		revenues = merchants.map {|merchant| merchant.revenue(date)}.reduce(:+)
	end

	def most_revenue(x)
		merchants.sort_by(&:revenue).reverse.take(x)
	end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

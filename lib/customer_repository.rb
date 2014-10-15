require_relative 'customer_parser'
require_relative 'customer'

class CustomerRepository
	attr_reader :customers, :sales_engine

	def initialize(file_path, sales_engine)
		@customers = CustomerParser.new(file_path).all(self)
		@sales_engine = sales_engine
	end

	def all
		customers
	end

	def random
		customers.sample
	end

	def find_by_id(value)
		customers.find {|customer| customer.id == value}
	end

	def find_by_first_name(value)
		customers.find {|customer| customer.first_name.downcase == value.downcase }
	end

	def find_by_last_name(value)
		customers.find {|customer| customer.last_name.downcase == value.downcase }
	end

	def find_by_created_at(value)
		customers.find {|customer| customer.created_at == value}
	end

	def find_by_updated_at(value)
		customers.find {|customer| customer.created_at == value}
	end

	def find_all_by_id(value)
		customers.find_all {|customer| customer.id == value}
	end

	def find_all_by_first_name(value)
		customers.find_all {|customer| customer.first_name.downcase == value.downcase}
	end

	def find_all_by_last_name(value)
		customers.find_all {|customer| customer.last_name.downcase == value.downcase}
	end

	def find_all_by_created_at(value)
		customers.find_all {|customer| customer.created_at == value}
	end

	def find_all_by_updated_at(value)
		customers.find_all {|customer| customer.created_at == value}
	end

	def find_invoices_for(id)
		sales_engine.find_invoices_by_customer(id)
	end

	def find_transactions_for(id)
		sales_engine.find_transactions_by_customer(id)
	end

	def find_merchants_for(id)
		sales_engine.find_merchants_by_customer(id)
	end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end

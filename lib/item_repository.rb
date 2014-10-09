require_relative 'item_parser'
require_relative 'item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(file_path, sales_engine)
    @items        = ItemParser.new(file_path).all(self)
    @sales_engine = sales_engine
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by(attribute, value)
    items.find {|items| items.send(attribute.to_sym) == value}
  end

  def find_all_by(attribute, value)
    items.find_all {|items| items.send(attribute.to_sym) == value}
  end

  def find_by_id(value); find_by(:id, value) end
  def find_by_name(value); find_by(:name, value) end
  def find_by_description(value); find_by(:description, value) end
  def find_by_unit_price(value); find_by(:unit_price, value.to_d) end
  def find_by_merchant_id(value); find_by(:merchant_id, value) end
  def find_by_created_at(value); find_by(:created_at, value) end
  def find_by_updated_at(value); find_by(:updated_at, value) end

  def find_all_by_id(value); find_all_by(:id, value) end
  def find_all_by_name(value); find_all_by(:name, value) end
  def find_all_by_description(value); find_all_by(:description, value) end
  def find_all_by_unit_price(value); find_all_by(:unit_price, value) end
  def find_all_by_merchant_id(value); find_all_by(:merchant_id, value) end
  def find_all_by_created_at(value); find_all_by(:created_at, value) end
  def find_all_by_updated_at(value); find_all_by(:updated_at, value) end

  def find_merchant_for(id)
    sales_engine.find_merchant_by_item(id)
  end

  def find_invoice_items_for(id)
    sales_engine.find_invoice_items_by_item(id)
  end

  def inspect
    "#<#{self.ItemRepository} #{@items.size} rows>"
  end
end

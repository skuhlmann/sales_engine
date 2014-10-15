require_relative 'test_helper'

class IntegrationTest < Minitest::Test 

# MerchantRepository
# most_revenue(x) returns the top x merchant instances ranked by total revenue
# most_items(x) returns the top x merchant instances ranked by total number of items sold
# revenue(date) returns the total revenue for that date across all merchants

#Merchant
#revenue returns the total revenue for that merchant across all transactions
#revenue(date) returns the total revenue for that merchant for a specific invoice date
#favorite_customer returns the Customer who has conducted the most successful transactions
#customers_with_pending_invoices returns a collection of Customer instances which have pending (unpaid) invoices. An invoice is considered pending if none of it’s transactions are successful.


# ItemRepository
# most_revenue(x) returns the top x item instances ranked by total revenue generated
# most_items(x) returns the top x item instances ranked by total number sold

# Item
# best_day returns the date with the most sales for the given item using the invoice date

# Customer
# #transactions returns an array of Transaction instances associated with the customer
# #favorite_merchant returns an instance of Merchant where the customer has conducted the most successful transactions

#invoice creation - .create and .charge

end
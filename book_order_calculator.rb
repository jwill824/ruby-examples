#!/usr/bin/ruby -w

=begin
Program Title:     Book Order Total Cost Calculator
Developer Name:    Hannah Mulkey
Date:              05/20/2018
Course/Instructor: CIS 116 Computer Programming I
Program Summary:   Calculates grand total of a customer book order, including
                   shipping and discount rates.
=end

Inf = 1.0/0 # declare Infinity to use in switch/case

def prompt(*args)
  input_arg=false
  until input_arg do # quits when input_arg=true
    print(*args) # prints the input which prompts the user visually
    value=Float(gets) # converts inputted arg as Float
    input_arg = value rescue false # checks if input is Float, otherwise continues to prompt
  end
  return value # finally returns value
end

def calculate_order(book_price, book_weight, book_quantity)
  initial_order_cost = book_price.to_f * book_quantity.to_f # Calculates base order amount i.e. $5/book * 45 books = $225
  discount_rate = case book_quantity # switch/case for calculating discount rate based on amount of books ordered
    when 10..39 then 0.10
    when 40..69 then 0.20 # 45 books will get us here
    when 70..99 then 0.30
    when 100..Inf then 0.40
    else 0
  end
  # Calculates discount of order based on discount rate determined above i.e. $225 - ($225 * 0.20) = $180
  potential_discount_order_cost = initial_order_cost.to_f - (initial_order_cost.to_f * discount_rate.to_f)
  savings_amount = initial_order_cost.to_f - potential_discount_order_cost.to_f # Finds amount saved by simple arithmetic (only for displaying to console)
  total_order_weight = book_weight.to_f * book_quantity.to_f # Calculates total weight of order i.e. 1.5lbs/book * 45 books = 67.5 lbs
  shipping_rate = case total_order_weight # switch/case for calculating shipping rate based on the total weight of the order
    when 0..2 then 0.10
    when 2..9 then 0.20
    when 10..39 then 0.30
    when 40..69 then 0.50  # 67.5 lbs gets us here
    when 70..99 then 0.75
    when 100..Inf then 0.90
    else 0
  end
  additional_shipping_cost = total_order_weight.to_f * shipping_rate.to_f # Calculates the total shipping cost i.e. 67.5 lbs * 0.50 = $33.75

  # Prints out display values required
  puts "Book Quantity: #{book_quantity} books \n"
  puts "Book Weight: #{book_weight} lbs per book \n"
  puts "Discount Applied: #{discount_rate * 100}% \n"
  puts "Savings Amount: $#{savings_amount} \n"
  puts "Initial Order Cost: $#{initial_order_cost} \n"
  puts "Shipping Cost: $#{additional_shipping_cost} \n"

  # Returns grand total
  return (potential_discount_order_cost.to_f + additional_shipping_cost.to_f) # Adds the order cost (with or without discount) with the potential shipping cost
end

# User Input - calls prompt def
book_price = prompt "Price of each book (in dollars): "
book_weight = prompt "Weight of each book (in lbs): "
book_quantity = prompt "Number of book copies to be purchased: "

# Prints Grand Total - using inline def reference
puts "Grand Total: $#{calculate_order book_price, book_weight, book_quantity}"

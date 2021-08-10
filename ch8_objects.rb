#!/usr/bin/ruby -w

Inf = 1.0/0

def prompt(*args)
  input_arg=false
  until input_arg do
    print(*args)
    value=Float(gets) rescue false
    input_arg=value rescue false
    if (0..Inf) === value
      input_arg=true
    else
      input_arg=false
    end
  end
  return value
end

def create_monthly_bills_array(month_array, indicator)
  bills = Array.new
  puts "Monthly bill amounts #{indicator} installation: "
  month_array.each_with_index do |month, i|
    bill = prompt "#{month} amount: $"
    bills.insert(i, bill.to_f)
  end
  puts "\n"
  return bills
end

def create_monthly_savings_array(month_arry, before, after)
  savings_array = Array.new(after.length) {Array.new(2)}

  month_arry.each_with_index do |month, i|
    savings_array[i][0] = month
    savings_array[i][1] = before[i].to_f - after[i].to_f
  end

  return savings_array.to_h
end

def display_monthly_savings(monthly_savings)
  savings_by_month = sort_savings_by_month_asc(monthly_savings)
  savings_by_val = sort_savings_by_value_desc(monthly_savings)

  printf "\n------------------------------\n"
  printf "|      Sorted By Month       |\n"
  printf "------------------------------\n"
  printf "| %-10s|  %5s  |\n", "Month [Asc]", "Savings Amt"
  printf "------------------------------\n"
  savings_by_month.each do |savings|
    printf "| %-10s |  %12s |\n", savings[0], "$" + (savings[1].round(2)).to_s
  end
  printf "------------------------------\n\n"

  printf "\n-----------------------------------\n"
  printf "|      Sorted By Savings          |\n"
  printf "-----------------------------------\n"
  printf "| %-10s|  %5s |\n", "Month", "Savings Amt [Desc]"
  printf "-----------------------------------\n"
  savings_by_val.each do |savings|
    printf "| %-10s|  %18s |\n", savings[0], "$" + (savings[1].round(2)).to_s
  end
  printf "-----------------------------------\n"
end

def sort_savings_by_month_asc(monthly_savings)
  return monthly_savings
end

def sort_savings_by_value_desc(monthly_savings)
  return monthly_savings.sort { |a,b| b[1] <=> a[1] }
end

def display_savings_forecast(upgrade_cost, yearly_savings)
  years = upgrade_cost.to_f / yearly_savings.to_f
  puts "\nYears till project savings turn a profit: #{years.round(0)} years"
end

month_array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

puts "The owner of a popular hotel chain wants to cut down on expenses in order to increase
profits. After doing some research, he discovers that he can save money by installing
more efficient sink and shower systems that use much less water. Each hotel is charged
monthly for its water usage, and he has kept a year’s worth of statements. He proceeds
to have the new system installed at one of the hotels and keeps track of all the expenses.
He then saves the water bill statements the year after the new system is in place.
The owner wants to see how much money he saved each month and for the year as a whole.\n\n"

upgrade_cost = prompt "How much was the system upgrade for the hotel? $"
puts "\n\nThe following is an analysis of monthly savings: \n"
bills_before_installation = [156.89, 145.56, 189.00, 151.43, 63.21, 89.89, 75.23, 158.01, 147.10, 145.56, 134.23, 145.10]
# bills_before_installation = create_monthly_bills_array(month_array, "before")
bills_after_installation = [150.65, 140.24, 154.21, 145.00, 60.00, 75.01, 75.00, 145.84, 140.01, 143.23, 129.09, 140.05]
# bills_after_installation = create_monthly_bills_array(month_array, "after")
monthly_savings = create_monthly_savings_array(month_array, bills_before_installation, bills_after_installation) # savings after installation
yearly_savings = monthly_savings.values.sum # savings in total after installation
display_monthly_savings(monthly_savings)
display_savings_forecast(upgrade_cost, yearly_savings)

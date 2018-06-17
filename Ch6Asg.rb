#!/usr/bin/ruby -w

Inf = 1.0/0 # declare Infinity to use for range

def day_prompt(*args)
  input_arg=false
  until input_arg do # quits when input_arg=true
    print(*args) # prints the input which prompts the user visually
    value=Integer(gets) # converts inputted arg as Integer
    input_arg = value rescue false # checks if input is Integer, otherwise continues to prompt
    if (1..Inf) === value # range for acceptable days
      input_arg=true
    else
      input_arg=false
    end
  end
  return value # finally returns value
end

def temp_prompt(*args)
  input_arg=false
  until input_arg do # quits when input_arg=true
    print(*args) # prints the input which prompts the user visually
    value=Integer(gets) # converts inputted arg as Integer
    input_arg = value rescue false # checks if input is Integer, otherwise continues to prompt
    if (-30..120) === value # range for acceptable temperatures
      input_arg=true
    else
      input_arg=false
    end
  end
  return value # finally returns value
end

def get_above_avg_days(temps, avg_temp)
  above_avg_days = 0
  temps.each do |temp|
    if temp > avg_temp # checks what temps in the array are greater than the average temperature already calculated
      above_avg_days += 1 # increments the number of days that above the average
    end
  end
  return above_avg_days # finally returns value
end

def create_temps_array(days)
  temps = Array.new # initializes the array
  i = 0 # this is the starting index
  while i < days do # while loop that will exit when the index equals the number of days
    temp = temp_prompt "Day #{i+1} >> " # calls prompt to get temperature
    temps.insert(i, temp) # inserts the temperature retrieved from prompt into the array at the calculated index
    i += 1 # increment the index to continue in the loop
  end
  return temps # finally returns value
end

# Initial disclaimer (from example)
puts "This program will ask you to enter the high temperature for each day
over a number of days you specify. The temperatures must be entered
in Fahrenheit units and range from -30 to 120. Once you've entered the
data, the program will present an analysis.\n\n"

# Prompt for retrieving the number of days
days = day_prompt "Please specify the number of days? "

# Prompt for entering temperatures for each day; creates the array of temps
temps = create_temps_array(days)

# Calculations
avg_temp = temps.inject(0.0) { |sum, i| sum + i } / temps.size # inject is an array function that allows you to act on the elements, in this case getting the sum and dividing by the size
above_avg_days = get_above_avg_days(temps, avg_temp) # calls above definition
above_avg_days_pct = (above_avg_days.to_f / days.to_f) * 100 # gets the percentage
lowest_temp = temps.each_with_index.min # gets the min value from the array with it's associated index
highest_temp = temps.each_with_index.max # gets the max value from the array with it's associated index

# Display
# Note: this and the other puts statements are using string formatting based on printf arguments
puts "An analysis of the data reveals that..."
puts "  The average temperature was %.1f " % [avg_temp] # %.1f = round 1 decimal point float
puts "  Temperatures were above average #{above_avg_days} of the #{days} days (#{above_avg_days_pct.round(0)}%) " # had to do this string output due to including a '%' sign
puts "  The lowest temperature dropped to %d on day %d " % [lowest_temp[0], lowest_temp[1]+1] # %d = decimal
puts "  The highest temperature reached %d on day %d " % [highest_temp[0], highest_temp[1]+1]

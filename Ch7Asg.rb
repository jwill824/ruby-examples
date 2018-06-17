#!/usr/bin/ruby -w
require 'time'

Inf = 1.0/0 # declare Infinity to use for range

def prompt(*args)
  input_arg=false
  until input_arg do # quits when input_arg=true
    print(*args) # prints the input which prompts the user visually
    value = Integer(gets) rescue false # converts inputted arg as Integer
    input_arg = value rescue false # checks if input is Integer, otherwise continues to prompt
    if (1..Inf) === value # range for acceptable days
      input_arg=true
    else
      input_arg=false
    end
  end
  return value # finally returns value
end

def time_diff_milli(start, finish)
   (finish - start) * 1000.0
end

def insertion_sort(array)
  num_compare = 0
  for i in (0..array.length - 1)
    j = i
    done = false
    while ((j > 0) and (! done))
      num_compare = num_compare + 1
      if (array[j] < array[j - 1])
        temp = array[j - 1]
        array[j - 1] = array[j]
        array[j] = temp
      else
        done = true
      end
      j = j - 1
    end
  end
  puts "Insertion Algorithm... done."
end

def bubble_sort(array)
  num_compare=0
  for i in (0..array.length - 2)
    for j in (i + 1)..(array.length - 1)
      num_compare = num_compare + 1
      if (array[i] > array[j])
        temp = array[j]
        array[j] = array[i]
        array[i] = temp
      end
    end
  end
  puts "Bubble Algorithm... done."
end

def selection_sort(array)
  num_compare = 0
  for i in (0..array.length - 2)
    min_pos = i
    for j in (i + 1)..(array.length - 1)
      num_compare = num_compare + 1
      if (array[j] < array[min_pos])
        min_pos = j
      end
    end
    temp = array[i]
    array[i] = array[min_pos]
    array[min_pos] = temp
  end
  puts "Selection Algorithm... done."
end

def radix_sort(array, limit)
  for i in (0..array.length - 1)
    array[i] = rand(limit + 1).to_s
  end

  max_length = 0
  for i in (0..array.length - 1)
    if array[i].length > max_length
      max_length = array[i].length
    end
  end

  for i in (0..array.length - 1)
    array[i] = array[i].rjust(max_length, "0")
  end

  for i in (0..max_length - 1)
    buckets = Hash.new
    for j in 0..9
      buckets[j.to_s] = Array.new
    end

    for j in 0..(array.length - 1)
      num = array[j]
      digit = num[max_length - 1 - i]
      buckets[digit].push(num)
    end
    array = buckets.values.flatten
  end
  puts "Radix Algorithm... done."
end

def ruby_array_sort(array)
  array.sort!
  puts "Ruby Algorithm... done."
end

def create_sorting_array(values, limit)
  return Array.new(values) { rand(0...limit) }
end

def process_algorithm_durations(sort_algorithms, array, limit)
  durations = Array.new(sort_algorithms.length) {Array.new(2)}
  i = 0
  sort_algorithms.each do |algorithm|
    start = Time.now

    case algorithm
    when "Insertion"
      insertion_sort array
    when "Bubble"
      bubble_sort array
    when "Selection"
      selection_sort array
    when "Radix"
      radix_sort array, limit
    when "Ruby Array Sort Method"
      ruby_array_sort array
    end

    finish = Time.now

    diff = time_diff_milli start, finish
    durations[i][0] = algorithm
    durations[i][1] = diff
    i += 1
  end

  return durations
end

def print_durations(durations)
  durations = durations.sort { |a,b| b[1] <=> a[1] }
  durations.each do |algorithm|
    printf "%-32s %2sms\n", algorithm[0], algorithm[1].to_f.round(0)
  end
end

# ==============================================================================

sort_algorithms = ["Insertion", "Bubble", "Selection", "Radix", "Ruby Array Sort Method"]

values = prompt "How many values do you want to sort? "
limit = prompt "What is the upper limit of the values to be sorted? "
array = create_sorting_array values, limit

puts "\n\n"

durations = process_algorithm_durations sort_algorithms, array, limit

puts "\n\n"

puts "==========================================
Algorithm Analysis
Data Set: #{values} integers between 0 and #{limit}
==========================================
Algorithm                       Duration
------------------------------------------"
print_durations durations
puts "------------------------------------------"

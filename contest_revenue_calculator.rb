#!/usr/bin/ruby -w

def prompt(*args)
  input_arg=false
  until input_arg do # quits when input_arg=true
    print(*args) # prints the input which prompts the user visually
    value=Integer(gets) # converts inputted arg as Float
    input_arg = value rescue false # checks if input is Float, otherwise continues to prompt
    if (0..30) === value
      input_arg=true
    else
      input_arg=false
    end
  end
  return value # finally returns value
end

prev_contest_count = prompt "How many contestants entered last year's competition? "
curr_contest_count = prompt "How many contestants entered this year's competition? "

if curr_contest_count > (2 * prev_contest_count)
  puts "The competition is bigger than ever!"
elsif (curr_contest_count > prev_contest_count && prev_contest_count < (2*prev_contest_count))
  puts "A tighter race this year! Come out and cast your vote!"
end

puts "Last year's contestant count: #{prev_contest_count} contestants"
puts "This year's contestant count: #{curr_contest_count} contestants"

puts "Last year's revenue: $#{prev_contest_count * 25}"
puts "This year's revenue: $#{curr_contest_count * 25}"

revenue_percentage_of_prev_verses_curr=((prev_contest_count.to_f * 25) / (curr_contest_count.to_f * 25)).to_f
percentage_diff=(100 - (revenue_percentage_of_prev_verses_curr * 100)).to_f
differential = case percentage_diff
  when 1..100 then "Previous year's revenue was #{percentage_diff.round(1)}% less than the current year's revenue"
  when -100..-1 then "Previous year's revenue was #{(percentage_diff * -1).round(1)}% more than the current year's revenue"
  else "Previous year's revenue was the same as the current year's revenue"
end
puts differential

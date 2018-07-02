#!/usr/bin/ruby -w

def prompt(*args, max)
  input_arg=false
  until input_arg do
    print(*args)
    value=Integer(gets)
    input_arg = value rescue false
    if (1..max) === value
      input_arg=true
    else
      input_arg=false
    end
  end
  return value
end

class Array
  # binary search
  def search(x, min=1, max=length-1)
    mid = (max + min) / 2
    case (x <=> self[mid])
      when -1 then
        puts "#{self[mid]} is too high!"
        max = mid - 1
      when 1 then
        puts "#{self[mid]} is too low!"
        min = mid + 1
      when 0 then
        puts "The computer found your value: #{self[mid]}"
        return
    end
    search(x, min, max)
  end
end

Inf = 1.0/0
max = prompt("Choose your range: ", Inf)
value = prompt("Choose your value for the computer to solve: ", max)
(1..max).to_a.search(value)

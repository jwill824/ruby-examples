#!/usr/bin/ruby -w

class Player
  # class variables
  MIN_HEALTH = 0
  MAX_HEALTH = 100
  MAX_HIT_POINTS = 25
  HIT_TARGET = 15

  # accessor methods
  attr_accessor :name, :health

  # constructor method
  def initialize(name = nil, health = nil)
   @name, @health = name, health
  end

  # setter methods
  def setHealth(value)
   @health = value

   if (value < MIN_HEALTH)
     @health = MIN_HEALTH
   elsif (value > MAX_HEALTH)
     @health = MAX_HEALTH
   end
  end

  # action method
  def attack(opponent)
   hit_points = rand(MAX_HIT_POINTS)

   if (MIN_HEALTH..HIT_TARGET) === hit_points
     opponent.setHealth(opponent.health - hit_points)
   end
  end
end

p1 = Player.new("Godzilla", 100)
p2 = Player.new("Mothra", 100)

until p1.health == 0 || p2.health == 0 do
  p1.attack(p2)
  p2.attack(p1)

  puts "#{p1.name} health is at #{p1.health}\n"
  puts "#{p2.name} health is at #{p2.health}\n\n"

  if (p2.health == 0)
    puts "The winner between #{p1.name} and #{p2.name} is: #{p1.name}"
  elsif (p1.health == 0)
    puts "The winner between #{p1.name} and #{p2.name} is: #{p2.name}"
  end
end

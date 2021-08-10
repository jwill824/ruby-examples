#!/usr/bin/ruby -w

class Candle
  DOLLARS_PER_INCH = 2

  attr_accessor :color, :height
  attr_reader :price

  def initialize(color, height)
    @color = color
    @height = height
    @price = DOLLARS_PER_INCH
  end

  def getPrice
    @price * @height
  end

  def to_s(name)
    "Name: #{name} \n Color: #{self.color} \n Height: #{self.height}in \n Price: $#{self.getPrice}"
  end
end

class ScentedCandle < Candle
  DOLLARS_PER_INCH = 3

  attr_accessor :scent

  def initialize(color, height, scent)
    super(color, height)
    @price = DOLLARS_PER_INCH
    @scent = scent
  end

  def getPrice()
    @price * @height
  end

  def to_s(name)
    super(name) + " \n Scent: #{self.scent}"
  end
end

genericCandle = Candle.new("beige", 7)
scentedCandle = ScentedCandle.new("pink", 7, "lavendar")

puts genericCandle.to_s("Candle")
puts scentedCandle.to_s("Scented Candle")

# class to represent city location in plane coordinates {x;y}
class City
  attr_accessor :x_cor, :y_cor

  def initialize(x, y)
    @x_cor = x
    @y_cor = y
  end

  # Method to find distance between two cities
  def distance(another_city)
    x_distance = (@x_cor - another_city.x_cor).abs
    y_distance = (@y_cor - another_city.y_cor).abs
    Math.sqrt((x_distance ** 2) + (y_distance ** 2)).round(2)
  end

  def to_s
    "{#{x_cor};#{y_cor}}"
  end
end
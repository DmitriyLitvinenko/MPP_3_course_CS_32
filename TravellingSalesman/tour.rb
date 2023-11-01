# class to represent the full tour across all cities
class Tour
  attr_reader :cities, :fitness, :distance

  def initialize(cities)
    # combination of visited cities will be a chromosome
    # and single city in combination - is gene
    @cities = cities.shuffle # distributes elements of array randomly
    @fitness = nil
    @distance = nil
  end

  def distance
    return @distance if @distance # don`t calculate again, if already did it at least once
    # calculating the whole tour distance
    path_distance = 0.0
    cities.each_with_index do |city, index|
      from_city = city
      to_city = index + 1 < cities.size ? cities[index + 1] : cities[0] # the tour have to return to the first city
      path_distance += from_city.distance(to_city)
    end
    @distance = path_distance.round(2)
  end

  def fitness
    return @fitness if @fitness # don`t calculate again, if already did it at least once
    # the bigger this value is - the better tour is among others
    @fitness = (1 / distance.to_f).round(4)
  end

  def to_s
    cities.map(&:to_s).join('|')
  end
end
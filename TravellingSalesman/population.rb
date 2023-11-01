# class to represent a "population" of tours
class Population
  attr_accessor :tours

  def initialize(cities, population_size, mutation_rate)
    tours = []
    population_size.times do
      tours << Tour.new(cities) # creating different tours
    end
    # placing the most fittest tour at the beginning
    @tours = tours.sort_by {|tour| tour.fitness}.reverse!
    @mutation_rate = mutation_rate
  end

  def fittest_tour
    tours.first
  end

  # creating new generation
  def evolve!
    new_tours = [fittest_tour] # saving fittest tour for next generation (elitism)
    while new_tours.size < tours.size do
      # selecting parents for new generation
      parent1 = select_parent_tour(tours)
      parent2 = parent1
      # We dont`t wont to have the same parents because child will just duplicate it
      while parent2 == parent1
        parent2 = select_parent_tour(tours)
      end
      # creating child tour
      child1 = crossover(parent1, parent2)
      # possible mutation for child
      new_tours << mutate(child1)
    end
    # changing previous generation to new generation
    @tours = new_tours.sort_by {|tour| tour.fitness}.reverse!
  end

  def select_parent_tour(tours)
    # taking the fittest tour from 2 random tours
    tours.sample(2).max_by {|tour| tour.fitness}
  end

  # two-point crossover
  def crossover(parent1, parent2)
    child_cities = Array.new(parent1.cities.size)
    # selecting random two points in tour (chromosome)
    start_index = rand(0..parent1.cities.size - 1)
    end_index = rand(start_index..parent1.cities.size - 1)
    # Copy the cities of parent1 between points
    child_cities[start_index..end_index] = parent1.cities[start_index..end_index]
    # Find remain not included cities and put them in free spaces
    remaining_cities = parent2.cities.reject { |city| child_cities.include?(city) }

    remaining_cities.each_with_index do |city, _|
      next unless child_cities.include?(nil)

      child_cities[child_cities.index(nil)] = city
    end

    Tour.new(child_cities)
  end

  # swap mutation
  def mutate(tour)
    tour.cities.each_with_index do |_, index|
      next if rand > @mutation_rate
      # selecting city for swapping
      swap_with_index = rand(0..tour.cities.size - 1)
      # swapping cities (genes)
      tour.cities[index], tour.cities[swap_with_index] = tour.cities[swap_with_index], tour.cities[index]
    end
    tour
  end

end
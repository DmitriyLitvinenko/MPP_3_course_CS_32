require_relative './city'
require_relative './tour'
require_relative './population'

mutation_rate = 0.015 # default mutation rate
population_size = 5 # default population size
max_generations = 30 # default num of generations
# Creating some cities
cities = Array.new(7) {City.new(rand(25)-10, rand(25)-10)}
puts "Cities coordinates:"
puts cities
# Creating first population
population = Population.new(cities, population_size, mutation_rate)
# Starting "Evolving" process
max_generations.times do |i|
  puts "Generation #{i + 1}"
  puts "Fittest tour: #{population.fittest_tour.to_s} Distance: #{population.fittest_tour.distance} Fitness: #{population.fittest_tour.fitness}"
  population.evolve!
end
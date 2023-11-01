require_relative './genome'
require_relative './KnapsackGeneticAlgorithm'

items = [[23,92],[31,57],[29,49],[44,68],[53,60],[38,43],[63,67],[85,84],[89,87],[82,72]] # List of items and their weights and values.
#items = Array.new(10) {Array.new(2) {rand (100)+1}} # random items
puts "Item list [weight, value]:"
items.each { |item| printf "#{item}"}

max_weight = 165 # Maximum weight that the knapsack can hold.
#max_weight = rand(100)+1 # random value for max_weight
puts "\nmax_weight:#{max_weight}"

ga = KnapsackGeneticAlgorithm.new(20, 0.01, 0.7, 5, 100) # Create a new genetic algorithm with the specified parameters.
ga.run(items, max_weight) # Run the genetic algorithm on the list of items.
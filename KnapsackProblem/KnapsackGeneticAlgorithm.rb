class KnapsackGeneticAlgorithm
  attr_accessor :population_size, :mutation_rate, :crossover_rate, :elitism, :max_generations

  # initializing all required variables
  def initialize(population_size, mutation_rate, crossover_rate, elitism, max_generations)
    @population_size = population_size
    @mutation_rate = mutation_rate
    @crossover_rate = crossover_rate
    @elitism = elitism
    @max_generations = max_generations
  end

  def run(items, max_weight)
    # Creating initial population
    current_population = Array.new(@population_size) { Genome.new }

    next_generation = []
    # finding initial best fitted solution
    best_fit = current_population.max_by { |chromosome| chromosome.fitness_value(items, max_weight)}.fitness_value(items, max_weight)
    puts "Initial Generation: Best fitness: #{best_fit}"

    generation_count = 0
    while generation_count < @max_generations
      # getting top solutions
      elites = current_population.max_by(@elitism) { |chromosome| chromosome.fitness_value(items, max_weight)}
      # The cycle of filling new generation
      (population_size / 2).times do
        new_gen_elements = selection(current_population)
        # Committing crossover for new generation elements
        new_gen_elements = crossover(new_gen_elements) if crossover_rate > rand
        # Committing mutation for new generation elements
        new_gen_elements[0].mutate!(mutation_rate)
        new_gen_elements[1].mutate!(mutation_rate)
        #Adding new elements
        next_generation << new_gen_elements[0] << new_gen_elements[1]
      end
      # Sorting from most fitted to less fitted
      next_generation.sort_by! {|chromosome| chromosome.fitness_value(items, max_weight)}.reverse!
      # If finding new best fitted solution - printing
      if next_generation[0].fitness_value(items, max_weight) > best_fit
        best_fit = next_generation[0].fitness_value(items, max_weight)
        puts "Generation #{generation_count}: Best fitness: #{best_fit}"
      end
      # making new generation the current generation (including elites from previous generation)
      current_population = next_generation + elites
      current_population.sort_by! {|chromosome| chromosome.fitness_value(items, max_weight)}.reverse!
      # Removing some less fitted solution to keep population size the same
      current_population.slice!(100, current_population.size)
      generation_count += 1
    end
    # printing result
    puts "Best fitness: #{best_fit}"
    puts current_population.first
    current_population[0].genes.each_with_index { |gene, index| printf "#{items[index]} " if gene == 1}
  end

  # Random select from population
  def selection(population)
    population.sample(2)
  end

  # Single-point crossover
  def crossover(parents)
    breakpoint = rand(parents[0].genes.size)
    child1_genes = parents[0].genes[0...breakpoint] + parents[1].genes[breakpoint..-1]
    child2_genes = parents[1].genes[0...breakpoint] + parents[0].genes[breakpoint..-1]
    [Genome.new(child1_genes), Genome.new(child2_genes)]
  end

end
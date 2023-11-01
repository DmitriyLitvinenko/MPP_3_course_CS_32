# class to represent included items in knapsack, 1 - item include, 0 - no item
class Genome
  attr_accessor :genes
  attr_reader :fitness

  def initialize(genes = nil)
    # chromosome is built of 10 genes (we will gave maximum of 10 items) which can be 1 or 0
    @genes = genes || Array.new(10) { rand(2) }
    @fitness = 0
  end

  def fitness_value(items, max_weight)
    weight = 0
    value = 0
    @genes.each_with_index do |gene, i|
      if gene == 1
        weight += items[i][0]
        value += items[i][1]
      end
      break if weight > max_weight
    end
    # set value for fitness only if included items weight not bigger then max_weight for knapsack
    @fitness = value if weight <= max_weight
    @fitness
  end

  # Flip bit mutation
  def mutate!(probability)
    @genes = @genes.map { |gene| gene == 1 ? 0 : 1} if probability > rand
  end

  def to_s
    @genes.join(",")
  end
end
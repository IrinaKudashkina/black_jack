class Gamer
  GAMER_TYPES = %w[игрок дилер].freeze

  attr_accessor :cards, :balance
  attr_reader :name, :type

  def initialize(name, type)
    @name = name.to_s.capitalize
    @type = type
    @cards = []
    @balance = 100
  end

  def sum_of_points
    sum, ace = 0, 0
    cards.each do |card|
      ace += 1 if card.include?("Т")
      sum += DECK[card]
    end
    (ace > 0 && sum + 10 > 21) || ace == 0 ? sum : sum + 10
  end

  def add_cart

  end

end

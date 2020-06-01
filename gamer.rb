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

  def score
    sum = 0
    ace = 0
    cards.each do |card|
      ace += 1 if card.include?("Т")
      sum += Game::DECK[card]
    end
    (ace.positive? && sum + 10 > 21) || ace.zero? ? sum : sum + 10
  end
end

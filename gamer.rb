class Gamer
  GAMER_TYPES = %w[игрок дилер].freeze

  def initialize(name, type)
    @name = name.to_s.capitalize
    @type = type
    @cards = []
    @balance = 100
  end
end

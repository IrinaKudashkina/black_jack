class GameSession

  attr_accessor :bank, :deck
  attr_reader :gamer, :dealer

  def initialize(gamer, dealer)
    @gamer = gamer
    @dealer = dealer
    @deck = DECK.keys
    @bank = 0
  end

  def distribute_to(player)
    card = deck[rand(0..deck.size)]
    player.cards << card
    deck.delete(card)
  end

  def bet_from(player)
    player.balance -= 10
    self.bank += 10
  end

  def start
    2.times { distribute_to(gamer) }
    2.times { distribute_to(dealer) }
    bet_from(gamer)
    bet_from(dealer)
  end
end
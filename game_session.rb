class GameSession
  def initialize(gamer, dealer)
    @gamer = gamer
    @dealer = dealer
    @deck = DECK.keys
    @bank = 0
  end
end
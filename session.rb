class Session
  attr_accessor :bank, :deck
  attr_reader :gamer, :dealer

  def initialize(gamer, dealer)
    @gamer = gamer
    @dealer = dealer
    @deck = Game::DECK.keys
    @bank = 0
  end

  def distribute_to(player)
    card = deck[rand(0...deck.size)]
    player.cards << card
    deck.delete(card)
  end

  def bet_from(player)
    player.balance -= 10
    self.bank += 10
  end

  def pay_to(player)
    player.balance += 10
    self.bank -= 10
  end

  def start
    gamer.cards = []
    dealer.cards = []
    2.times { distribute_to(gamer) }
    2.times { distribute_to(dealer) }
    bet_from(gamer)
    bet_from(dealer)
  end

  def find_winner
    winner = gamer
    if gamer.score == dealer.score || gamer.score > 21 && dealer.score > 21
      winner = "Ничья"
    elsif gamer.score <= 21 && dealer.score <= 21
      winner = dealer if dealer.score > gamer.score
    else
      winner = dealer if dealer.score < 21
    end
    winner
  end

  def result
    winner = find_winner
    if winner == "Ничья"
      pay_to(gamer)
      pay_to(dealer)
    else
      2.times { pay_to(winner) }
    end
    winner
  end
end

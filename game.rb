class Game
  deck = {}
  %w[+ <3 ^ <>].each do |suit|
    (2..10).to_a.each { |value| deck["#{value}#{suit}"] = value }
    %w[В Д К].each { |image| deck["#{image}#{suit}"] = 10 }
    deck["Т#{suit}"] = 1
  end
  DECK = deck.freeze

  attr_accessor :gamer, :dealer, :session, :messenger, :menu

  def initialize(messenger, menu)
    @messenger = messenger
    @menu = menu
  end

  def start
    messenger.hello
    name = messenger.ask_for_name
    self.gamer = Gamer.new(name, Gamer::GAMER_TYPES[0])
    self.dealer = Gamer.new("Казино", Gamer::GAMER_TYPES[1])
    send menu.level_proposal
  end

  def session_start
    self.session = Session.new(gamer, dealer)
    session.start
    messenger.show_cards(gamer, dealer)
    gamer_turn
  end

  def gamer_turn
    if gamer.cards.size == 2
      send menu.level_gamer_turn_full
    else
      send menu.level_gamer_turn
    end
  end

  def dealer_turn
    if dealer.score >= 17 || dealer.cards.size == 3
      messenger.skip(dealer)
    else
      session.distribute_to(dealer)
      messenger.take(dealer)
      check_3cards!
      messenger.show_cards(gamer, dealer)
    end
    gamer_turn
  end

  def add_card
    session.distribute_to(gamer)
    check_3cards!
    messenger.show_cards(gamer, dealer)
    dealer_turn
  end

  def open_cards
    messenger.open(gamer, dealer)
    session_end
  end

  def check_3cards!
    open_cards if gamer.cards.size == 3 && dealer.cards.size == 3
  end

  def session_end
    messenger.finish
    winner = session.result
    if winner == "Ничья"
      messenger.draw
    else
      messenger.win(winner)
    end
    send menu.level_proposal
  end

  def end_game
    messenger.good_bye
    exit 0
  end
end

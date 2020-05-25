class GameMenu
  PROPOSAL = { 1 => :session_start, 0 => :exit_program }.freeze
  GAMER_TURN_FULL = { 1 => :dealer_turn, 2 => :add_card, 3 => :open_cards }.freeze
  GAMER_TURN = { 1 => :dealer_turn, 2 => :open_cards }.freeze

  attr_accessor :gamer, :dealer, :session

  def initialize
    puts "Вас приветствует игра Black Jack!"
  end

  def main
    puts "Введите Ваше имя"
    name = gets.chomp.to_s
    self.gamer = Gamer.new(name, Gamer::GAMER_TYPES[0])
    self.dealer = Gamer.new("Казино", Gamer::GAMER_TYPES[1])
    proposal
  end

  def menu_master(level, go_to, the_object = nil)
    #cancel_choice
    user_choice = gets.chomp.to_i
    limit = level.keys.length - 1
    if the_object
      send(level[user_choice] || restart(limit, go_to), the_object)
    else
      send level[user_choice] || restart(limit, go_to)
    end
  end

  def restart(limit, go_to)
    puts "Введите цифру от 0 до #{limit}"
    go_to
  end

  def proposal
    puts "Начать новую игру? Да - 1  Нет - 0"
    menu_master(PROPOSAL, :proposal)
  end

  def session_start
    self.session = GameSession.new(gamer, dealer)
    session.start
    show_cards
    gamer_turn
  end

  def show_cards
    puts "#{gamer.name}, Ваши карты: #{gamer.cards.join(", ")}. Сумма очков: #{gamer.sum_of_points}"
    puts "Карты #{dealer.name}: #{'* ' * dealer.cards.size}"
  end

  def gamer_turn
    if gamer.cards.size == 2
      puts "#{gamer.name}, Ваш ход! Пропустить - 1  Добавить карту - 2  Открыть карты - 3"
      menu_master(GAMER_TURN_FULL, :gamer_turn)
    else
      puts "#{gamer.name}, Ваш ход! Пропустить - 1  Открыть карты - 2"
      menu_master(GAMER_TURN, :gamer_turn)
    end
  end

  def dealer_turn
    if dealer.sum_of_points >= 17
      puts "#{dealer.name} пропускает ход"
    else
      session.distribute_to(dealer)
      puts "#{dealer.name} берет карту"
      check_3cards!
      show_cards
    end
    gamer_turn
  end

  def add_card
    session.distribute_to(gamer)
    check_3cards!
    show_cards
    dealer_turn
  end

  def open_cards
    puts "#{gamer.name}, Ваши карты: #{gamer.cards.join(", ")}. Сумма очков: #{gamer.sum_of_points}"
    puts "Карты #{dealer.name}: #{dealer.cards.join(", ")}. Сумма очков: #{dealer.sum_of_points}"
    result
  end

  def check_3cards!
    open_cards if gamer.cards.size == 3 && dealer.cards.size == 3
  end

  def result
    puts "Подсчет результатов"
    proposal
  end

  def exit_program
    puts "Спасибо за интерес к нашей игре! До новых встреч!"
  end
end

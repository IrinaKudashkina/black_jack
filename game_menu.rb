class GameMenu
  PROPOSAL = { 1 => :session_start, 0 => :exit_program }.freeze

  attr_accessor :gamer, :dealer

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
    session = GameSession.new(gamer, dealer)
    session.start
    show_cards
  end

  def show_cards
    puts "#{gamer.name}, Ваши карты: #{gamer.cards.join(", ")}. Сумма очков: #{gamer.sum_of_points}"
    puts "Карты #{dealer.name}: #{'* ' * dealer.cards.size}"
  end

  def exit_program
    puts "Спасибо за интерес к нашей игре! До новых встреч!"
  end

end

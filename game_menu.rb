class GameMenu
  PROPOSAL = { 1 => :start, 0 => :exit_program }.freeze

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

  def start
    puts GameSession.new(gamer, dealer).inspect
    puts gamer.inspect
    puts dealer.inspect
  end

  def exit_program
    puts "Спасибо за интерес к нашей игре! До новых встреч!"
  end

end

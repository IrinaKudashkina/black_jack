class Messenger
  def hello
    puts "Вас приветствует игра Black Jack!"
  end

  def ask_for_name
    puts "Введите Ваше имя"
    gets.chomp.to_s
  end

  def proposal
    puts "Начать новую игру? Да - 1  Нет - 0"
    gets.chomp.to_i
  end

  def error
    puts "Выберите из предложенных вариантов"
  end

  def show_cards(gamer, dealer)
    puts "#{gamer.name}, Ваши карты: #{gamer.cards.join(', ')}. Сумма очков: #{gamer.score}"
    puts "Карты #{dealer.name}: #{'* ' * dealer.cards.size}"
  end

  def turn_full
    puts "Ваш ход! Пропустить - 1  Добавить карту - 2  Открыть карты - 3"
    gets.chomp.to_i
  end

  def turn
    puts "Ваш ход! Пропустить - 1  Открыть карты - 2"
    gets.chomp.to_i
  end

  def skip(dealer)
    puts "#{dealer.name} пропускает ход"
  end

  def take(dealer)
    puts "#{dealer.name} берет карту"
  end

  def open(gamer, dealer)
    puts "#{gamer.name}, Ваши карты: #{gamer.cards.join(', ')}. Сумма очков: #{gamer.score}"
    puts "Карты #{dealer.name}: #{dealer.cards.join(', ')}. Сумма очков: #{dealer.score}"
  end

  def finish
    puts "Игра окончена!"
  end

  def draw
    puts "Ничья"
  end

  def win(winner)
    puts "Победитель: #{winner.name}"
  end

  def good_bye
    puts "Спасибо за интерес к нашей игре! До новых встреч!"
  end
end

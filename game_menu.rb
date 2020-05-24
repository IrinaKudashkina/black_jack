class GameMenu
  deck = {}
  %w(+ <3 ^ <>).each do |suit|
    (2..10).to_a.each { |value| deck["#{value}#{suit}"] = value}
    %w(В Д К).each { |image| deck["#{image}#{suit}"] = 10 }
    deck["Т#{suit}"] = 1
  end
  DECK = deck.freeze
end

puts GameMenu::DECK

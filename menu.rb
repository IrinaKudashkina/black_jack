class Menu
  PROPOSAL = { 1 => :session_start, 0 => :end_game }.freeze
  GAMER_TURN_FULL = { 1 => :dealer_turn, 2 => :add_card, 3 => :open_cards }.freeze
  GAMER_TURN = { 1 => :dealer_turn, 2 => :open_cards }.freeze

  attr_reader :messenger

  def initialize(messenger)
    @messenger = messenger
  end

  def menu_master(level, go_to, user_choice)
    level[user_choice] || restart(go_to)
  end

  def level_proposal
    user_choice = messenger.proposal
    menu_master(PROPOSAL, :level_proposal, user_choice)
  end

  def level_gamer_turn
    user_choice = messenger.turn
    menu_master(GAMER_TURN, :level_gamer_turn, user_choice)
  end

  def level_gamer_turn_full
    user_choice = messenger.turn_full
    menu_master(GAMER_TURN_FULL, :level_gamer_turn_full, user_choice)
  end

  def restart(go_to)
    messenger.error
    send go_to
  end
end

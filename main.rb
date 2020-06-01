require_relative "game"
require_relative "gamer"
require_relative "session"
require_relative "messenger"
require_relative "menu"

messenger = Messenger.new
menu = Menu.new(messenger)
Game.new(messenger, menu).start

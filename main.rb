require_relative 'modules/game_window'

class Main
    def initialize()
       @window = GameWindow.new()
       @window.show()
    end
end

game = Main.new()
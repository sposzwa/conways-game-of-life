require_relative 'modules/game_logic'
require_relative 'modules/map_service.rb'

$SPEED = 1

class Main
    def initialize()
       @session = Session.new(10,10)
    end
    def clear()
      if Gem.win_platform?
        system 'cls'
      else
        system 'clear'
      end
    end
    def loadStartingPattern()
        @session.load_game()
    end
    def start()
        self.clear()
        while true
            @session.print()
            @session.next_generation()
            sleep $SPEED
            self.clear()
        end
    end
end

game = Main.new()
game.loadStartingPattern()
game.start()
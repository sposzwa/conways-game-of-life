require 'gosu'
require_relative 'game_logic'

FONT = "assets/fonts/PressStart2P-Regular.ttf"

class GameWindow < Gosu::Window
    def initialize()
        super 1024, 768
        self.caption = "Conway's Game Of Life"
        @speed = 1
        @pause = false
        @tick = 0
        @current_screen = 0
        @session = nil
        @mouse_hold = false
        @background_images = [Gosu::Image.new("assets/images/menu.png", :tileable => true),Gosu::Image.new("assets/images/game-screen.png", :tileable => true)]
    end

    def update
        if @current_screen == 1
            if @tick >= 100 * @speed && !@pause 
                @session.next_generation()
                @tick = 0
            else 
                @tick += 1
            end
            if @mouse_hold && mouse_y>=106 && mouse_y <666 && mouse_x >= 0 && mouse_x <= 1024
                @session.set_cell(mouse_x,mouse_y-106) 
            end
            if @mouse_hold && (mouse_y<106 || mouse_y >=666 || mouse_x < 0 || mouse_x > 1024)
                @mouse_hold = false
            end
        end
    end

    def button_down(id)
        case id
        when Gosu::KbS
            case @current_screen
            when 0
                @session = Session.new(1024/8,560/8)
                @current_screen = 1
            when 1
                @session.save_game()
            end
        when Gosu::MS_LEFT
            if @current_screen == 1
                if mouse_y>=106 && mouse_y <666 && mouse_x >= 0 && mouse_x <= 1024
                    @session.set_cell(mouse_x,mouse_y-106) 
                    @mouse_hold = true
                end
            end
        when Gosu::KbL
            case @current_screen
            when 0
                @session = Session.new(1024/8,560/8)
                @session.load_game()
                @current_screen = 1
            when 1
                @session.load_game()
            end
        when Gosu::KbP
            if @current_screen == 1
                @pause = !@pause
            end
        when Gosu::KbE
            exit
        when Gosu::KbT
            if @current_screen == 1
                case @speed
                when 2
                    @speed = 1.5
                when 1.5
                    @speed = 1
                when 1
                    @speed = 0.5
                when 0.5
                    @speed = 0.25
                when 0.25
                    @speed = 2
                end
            end      
        when Gosu::KbC
            if @current_screen == 1
                @session = Session.new(1024/8,560/8)
            end
        when Gosu::KbM
            puts "Mute"
        end
    end

    def button_up(id)
        case id
        when Gosu::MS_LEFT
            if @mouse_hold
                @mouse_hold = false
            end
        end
    end

    def draw
        @background_images[@current_screen].draw(0, 0, 0)
        if @current_screen == 1
            self.draw_centered_text("GENERATION: " + @session.get_generation_number.to_s,20,FONT).draw(0, 43, 10, 1, 1, Gosu::Color::WHITE)
            for x in 0...1024/8
                for y in 0...560/8
                    case @session.get_cell(x,y)
                    when 1
                        draw_rect(x*8,106 + y*8,8,8,0xffCCBEFF,1)
                    when 2
                        draw_rect(x*8,106 + y*8,8,8,0xff9C70FF,1)
                    when 3
                        draw_rect(x*8,106 + y*8,8,8,0xff6E28D9,1)
                    when 4
                        draw_rect(x*8,106 + y*8,8,8,0xff2E0578,1)
                    end
                end
            end
        end
    end

    def draw_centered_text(text, size, font)
        centered_text = Gosu::Image.from_text(text, size, {:width => 1000, :align => :center, :font => font})
    end
end
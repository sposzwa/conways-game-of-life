require 'gosu'
#require './game_logic.rb'

class GameWindow < Gosu::Window
  def initialize(session)
    super 1024, 768
    self.caption = "Conway's Game Of Life"
    @font = Gosu::Font.new(36, name: "assets/fonts/VT323-Regular.ttf")
    @current_screen = 0
    @screen_array = [Gosu::Image.new("assets/images/TitleScreen.png", :tileable => true),
       Gosu::Image.new("assets/images/GameScreen.png", :tileable => true),
       Gosu::Image.new("assets/images/OptionsScreen.png", :tileable => true)]
    @screen_options = [['New game','Load','Exit'],['Randomize','Speed','Screen','Save','Load','Exit'],['Blank','Default','Preset 1','Preset 2']]
    @screen_opt_number = [2,3,3]
    @option_number = 0;
    #session = Session.new(3,4);
  end

  def parse_options(option)
    case option
    when 'New game'
      @current_screen = 2
      @option_number = 0 
    when 'Load'
      #puts 'Load'
      @current_screen = 1
      @option_number = 0
    when 'Exit'
      exit
    when 'Randomize'
      puts 'Rand'
    when 'Speed'
      puts 'Screen'
    when 'Save'
      puts 'Save'
    when 'Load'
      puts 'Load'
    when 'Exit'
      exit
    when 'Blank'
      puts 'Blank'
    when 'Default'
      puts 'Default'  
    when 'Preset 1'
      puts 'Preset 1'
    when 'Preset 2'
      puts 'Preset 2'
    end
  end

  def draw_centered_text(text, size, font)
    centered_text = Gosu::Image.from_text(text, size, {:width => 1000, :align => :center, :font => font})
  end
  
  def update
    if (Gosu.button_down? Gosu::KB_DOWN and !@pressedDW) or (Gosu::button_down? Gosu::GP_DOWN and !@pressedDW)
      if(@current_screen == 0 || @current_screen == 2)
          if(@option_number < @screen_opt_number[@current_screen])
              @option_number += 1
          end
      end
      @pressedDW = true
   
    elsif (Gosu.button_down? Gosu::KB_UP and !@pressedUP) or (Gosu::button_down? Gosu::GP_UP and !@pressedUP)
      if(@current_screen == 0 || @current_screen == 2)
          if(@option_number > 0)
              @option_number -= 1
          end
      end
      @pressedUP = true

    elsif (Gosu.button_down? Gosu::KB_A and !@pressedEN)
      selected_option = @screen_options[@current_screen][@option_number]
      parse_options(selected_option)
      @pressedEN = true

    elsif (!Gosu.button_down? Gosu::KB_A and @pressedEN)
      @pressedEN = false
    
    elsif (!Gosu.button_down? Gosu::KB_DOWN and @pressedDW) 
      @pressedDW = false
      
    elsif (!Gosu.button_down? Gosu::KB_UP and @pressedUP)
      @pressedUP = false
    end



  end
  
  def draw
    #draw_rect(0,10*@@pos,50,25,0xffffffff,2)
    if @current_screen == 0 || @current_screen == 2
      i = 0
      @screen_options[@current_screen].each do |n|
          @current_screen == 0 ? offset = 339 : offset = 250
          draw_rect(406, offset+61*@option_number,210,40,0xff33FF33,2)
          #@font.draw_text(n, 10, 50*i, 10)
          self.draw_centered_text(n,36,"assets/fonts/VT323-Regular.ttf").draw( 10, offset+61*i, 10, 1, 1, Gosu::Color::WHITE)
          i = i + 1
      end
    else
      i = 0
      @screen_options[@current_screen].each do |n|
          #draw_rect(150*i + 100 , 691,20,40,0xff33FF33,2)
          @font.draw_text(n, 150*i, 691, 10)
          #self.draw_centered_text(n,36,"assets/fonts/VT323-Regular.ttf").draw( 150*i - 3*150 + 100 , 691, 10, 1, 1, Gosu::Color::WHITE)
          i = i + 1
      end
    end
    @screen_array[@current_screen].draw(0, 0, 0)
  end
end
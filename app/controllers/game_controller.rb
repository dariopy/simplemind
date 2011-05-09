class GameController < ApplicationController
  before_filter :authenticate

  def newgame
    @title = "Game"
    @endgame = false
    @message = "You've got 8 tries"
    #create a new game
    #random binary string between 0000 and 1111
    game_number = "%04b" % rand(16)
    #convert to desired format, with dashes as separators
    game_string = game_number.chars.to_a.join("-") 
    #create the game and store in database
#    game = Game.create({:game_string => game_string, :won => false, :lost => false})
    game = Game.create({:game_string => game_string, :won => false, :lost => false})
    game.user = current_user
    game.save  
    @gameid = game.id
    #just testing
    @gamestring = game_string
    #display
    render 'game'
    #return
  end

  def guess
    @title = "Game"
    #default values here
    @winner = false
    @endgame = false
    hint = "You Win!"
    correct = 0
    #retrieve game id
    @gameid = params[:gameid]
    #obtain game and guesses from database
    game = Game.find(@gameid)
    #obtain previous list of guesses    
    #retrieve current guess values
    newguess = [params[:g1],params[:g2],params[:g3],params[:g4]].join('-')    
    #check if winner
    if newguess == game.game_string
      @winner = true
      @endgame = true
      game.won = true
      correct = 4
      @message = "Congratulations!"
    else
      #if not, prepare hint
      guess_a = newguess.split("-")
      game_a = game.game_string.split("-")      
      game_a.each_with_index { |val,i|
        correct += 1 if guess_a[i] == val
      }
      hint = "Correct: " + correct.to_s
    end
    #prepare previous list of guesses to display
    @guesses = []
    past_guesses = game.guesses
    if not past_guesses.blank?
      past_guesses_a = past_guesses.split('#')
      past_guesses_a.each { |item|
        #each item have a format like "0-0-1-0C2"
        past_guess = item.split("C")
        @guesses << {:guess => past_guess[0], :hint => "Correct: "+past_guess[1]}
      }
    end
    #add new guess to previous list of guesses
    @guesses << {:guess => newguess, :hint => hint}
    #did he just lost?
    if not @winner
      if @guesses.length >= 8
        game.lost = true
        @endgame = true
        @message = "Sorry!"
      else
        triesleft = 8 - @guesses.count
        tries = triesleft > 1 ? "try".pluralize : "try"
        @message = "You've got #{triesleft} #{tries} left"
      end
    end
    #update game.guesses
    new_guesses = newguess + "C#{correct}"
    if not past_guesses.blank?
      new_guesses = past_guesses + '#' + new_guesses
    end
    game.guesses = new_guesses
    #and update database record
    game.save
    #display
    render 'game'
  end

  private

    def authenticate
      deny_access unless signed_in?
    end
 
end

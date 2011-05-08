class GameController < ApplicationController
  def newgame
    @message = "You've got 8 tries"
    #create a new game
    @gameid = 45
    #store it in database
    #display
    render 'game'
    #return
  end

  def guess
    #keep track of game id
    @gameid = params[:gameid]
    #obtain game and guesses from database
    #obtain previous list of guesses
    @guesses = [{:guess => "0-1-1-0",:correct => "2"},
      {:guess => "0-1-1-1",:correct => "3"},
      {:guess => "1-1-1-1",:correct => "3"}]    
    #retrieve guess parameters
    newguess = [params[:g1],params[:g2],params[:g3],params[:g4]].join('-')
    win = '99'
    #check if winner
    #add guess to previous list of guesses
    @guesses << {:guess => newguess, :correct => win}
    #disable form if winning or losing
    #display
    render 'game'
  end
 
end

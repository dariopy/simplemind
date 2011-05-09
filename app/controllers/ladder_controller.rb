class LadderController < ApplicationController
  before_filter :authenticate

  def show
    @title = 'Leaderboard Page'
    #mock version
    @the_ranking = []

    #@the_ranking << {:name => "Chuck Norris", :games => 9, :wins => 9, :losses => 0, :avg_guess => 1}
    #@the_ranking << {:name => "Dirty Harry", :games => 10, :wins => 8, :losses => 2, :avg_guess => 2.5}
    #@the_ranking << {:name => "Charles Bronson", :games => 24, :wins => 6, :losses => 15, :avg_guess => 5}

    #all the users
    players = User.all
    players.each do |player|
      ngames = player.games.count
      nwins = Game.find(:all, :conditions => ["user_id = :user AND won = :wins", {:user => player, :wins => true }]).count
      nloss = Game.find(:all, :conditions => ["user_id = :user AND lost = :losses", {:user => player, :losses => true }]).count
      avg_g = '%.2f' % count_guesses(player.games)
      @the_ranking << {:name => player.name, :games => ngames, :wins => nwins, :losses => nloss, :avg_guess => avg_g}
      #sort
      @the_ranking = (@the_ranking.sort_by { |my_item| my_item[:wins] }).reverse
    end


  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def count_guesses(games)
      total_g = 0
      n = games.count
      games.each { |game|
        if not game.guesses.nil?
          total_g += game.guesses.count('#') + 1
        end
      }
      n > 0 ? total_g.to_f / n : 0      
    end

end

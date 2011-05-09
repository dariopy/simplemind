require 'spec_helper'

describe GameController do
  render_views

  before(:each) do
    @attr = { :game_string => "1-0-0-1", :won => false, :lost => false }
    Game.create!(@attr)
  end

  describe "GET 'newgame'" do
    it "should be successful" do
      get 'newgame'
      response.should be_success
    end
  end

  describe "POST 'guess'" do
    it "should be successful" do
      post 'guess', :gameid => 1
      response.should be_success
    end
  end

end

require 'spec_helper'

describe Game do
  before(:each) do
    @attr = { :game_string => "1-0-0-1", :won => false, :lost => false }
  end

  it "should create a new instance given valid attributes" do
    Game.create!(@attr)
  end

  it "should require a game string" do
    no_string_game = Game.new(@attr.merge(:game_string => ""))
    no_string_game.should_not be_valid
  end
end

require 'spec_helper'

describe GameController do

  describe "GET 'newgame'" do
    it "should be successful" do
      get 'newgame'
      response.should be_success
    end
  end

  describe "GET 'guess'" do
    it "should be successful" do
      get 'guess'
      response.should be_success
    end
  end

end

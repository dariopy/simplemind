require 'spec_helper'

describe GameController do
  render_views

  describe "GET 'newgame'" do
    it "should be successful" do
      get 'newgame'
      response.should be_success
    end
  end

  describe "POST 'guess'" do
    it "should be successful" do
      post 'guess'
      response.should be_success
    end
  end

end

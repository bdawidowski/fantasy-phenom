class DataController < ApplicationController
  def mlb
    @games = MlbGame.all
  end

end
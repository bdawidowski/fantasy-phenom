class DataController < ApplicationController
  def mlb
    @games = MlbGame.all
    @updated_at = Time.at(MlbGame.first.updated_at.to_i).in_time_zone("Eastern Time (US & Canada)").strftime("%^B %e, %Y - %I:%M %p EST")
  end

end
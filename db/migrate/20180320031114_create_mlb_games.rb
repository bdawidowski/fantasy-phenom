class CreateMlbGames < ActiveRecord::Migration
  def change
    create_table :mlb_games do |t|
      t.string :away_team, default: ''
      t.string :home_team, default: ''

      t.text :away_batters, array: true, default: []
      t.text :home_batters, array: true, default: []

      t.text :team_batting_r, array: true, default: []
      t.text :team_batting_l, array: true, default: []
      t.text :team_batting_h, array: true, default: []
      t.text :team_batting_a, array: true, default: []

      t.string :away_bet, default: ''
      t.string :away_money_line, default: ''
      t.string :home_bet, default: ''
      t.string :home_money_line, default: ''

      t.string :degree, default: ''
      t.string :weather, default: ''
      t.string :wind, default: ''

      t.text :pitcher_home, array: true, default: []
      t.text :pitcher_away, array: true, default: []
      t.text :pitcher_left, array: true, default: []
      t.text :pitcher_right, array: true, default: []
      t.text :pitcher_road, array: true, default: []
      t.text :pitcher_30days, array: true, default: []
      t.text :pitcher_2017, array: true, default: []

      t.timestamps null: false
    end
  end
end

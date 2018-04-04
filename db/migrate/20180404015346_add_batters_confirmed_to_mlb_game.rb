class AddBattersConfirmedToMlbGame < ActiveRecord::Migration
  def change
    add_column :mlb_games, :away_batters_confirmed, :string, :default => ''
    add_column :mlb_games, :home_batters_confirmed, :string, :default => ''
  end
end

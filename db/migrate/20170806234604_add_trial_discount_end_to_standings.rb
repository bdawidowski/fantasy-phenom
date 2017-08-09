class AddTrialDiscountEndToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :ended_at, :timestamp
    add_column :standings, :trial_start, :timestamp
    add_column :standings, :trial_end, :timestamp
    add_column :standings, :discount, :string
  end
end

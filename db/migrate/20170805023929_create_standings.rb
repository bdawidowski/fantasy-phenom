class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :user_id
      t.string :stripe_id
      t.timestamp :current_period_end
      t.timestamp :current_period_start
      t.timestamp :canceled_at
      t.string :status

      t.timestamps null: false
    end
    add_index :standings, :stripe_id, unique: true
  end
end

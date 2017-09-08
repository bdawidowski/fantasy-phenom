class CreateGooglesheets < ActiveRecord::Migration
  def change
    create_table :googlesheets do |t|
      t.string :sport
      t.string :link
      t.timestamps null: false
    end
  end
end

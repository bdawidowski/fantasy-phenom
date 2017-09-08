class AddDateToGooglesheets < ActiveRecord::Migration
  def change
    add_column :googlesheets, :date_for, :string
  end
end

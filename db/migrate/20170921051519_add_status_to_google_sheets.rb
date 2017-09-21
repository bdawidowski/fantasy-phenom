class AddStatusToGoogleSheets < ActiveRecord::Migration
  def change
    add_column :googlesheets, :status, :boolean
  end
end

class ChangeTypeToCtype < ActiveRecord::Migration
  def change
      remove_column :contacts, :type
      add_column :contacts, :contype, :string, :default => "Unknown"
  end
end

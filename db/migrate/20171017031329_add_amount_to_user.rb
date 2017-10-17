class AddAmountToUser < ActiveRecord::Migration
  def change
    add_column :users, :amount, :string, :default => "0.00"
    change_column :users, :contributor, :boolean, :default => false
  end
end

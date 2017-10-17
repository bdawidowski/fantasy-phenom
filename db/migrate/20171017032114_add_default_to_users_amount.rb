class AddDefaultToUsersAmount < ActiveRecord::Migration
  def change
      change_column :users, :amount, :string, :default => "0.00"
  end
end

class AddPaypalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal, :boolean, default: false
  end
end

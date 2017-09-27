class AddRocketToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rocket_token, :string
    add_column :users, :rocket_pw, :string
  end
end

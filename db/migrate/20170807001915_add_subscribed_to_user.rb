class AddSubscribedToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscribed, :boolean
    add_column :users, :was_subscribed, :boolean
  end
end

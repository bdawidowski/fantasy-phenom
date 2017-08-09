class AddDefaultsToBooleans < ActiveRecord::Migration
  def change
    change_column_default :users, :subscribed, false
    change_column_default :users, :was_subscribed, false
    change_column_default :users, :chatroom, false
  end
end
